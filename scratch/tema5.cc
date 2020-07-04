#include <string>
#include "ns3/core-module.h"
#include "ns3/network-module.h"
#include "ns3/internet-module.h"
#include "ns3/point-to-point-module.h" 
#include "ns3/mobility-module.h"
#include "ns3/applications-module.h"
#include "ns3/brite-module.h"
#include "ns3/ipv4-nix-vector-helper.h"
#include "ns3/mobility-module.h"
#include "ns3/netanim-module.h"
#include "ns3/wifi-module.h" 
#include "ns3/stats-module.h" 
#include <iostream>
#include <fstream> 
#include <algorithm>
#include "ns3/dsr-module.h" 
#include "ns3/aodv-module.h" 
#include "ns3/olsr-module.h"
#include "ns3/dsdv-module.h"

#include "ns3/energy-module.h"  

using namespace ns3;
NS_LOG_COMPONENT_DEFINE ("ROUTING PROTOCOLS IN MANET");

uint32_t app_data_bytes_total = 0; 
uint32_t app_data_bytes_received = 0; 
uint32_t app_data_bytes_sent = 0; 
uint32_t app_data_packets_received = 0; 
uint32_t app_data_packets_sent = 0;
uint32_t routing_packets_sent = 0;
std::map<uint32_t, double> delay_table;
std::list<uint32_t> app_packets;
double average_delay = 0;
double jitter = 0;
double sum_jitter = 0;
float last_delay = 0;
int numberOfApplications = 0;
bool first = true;
double nodeSpeed = 2.0;
double proc = 0.5;
uint32_t routingProtocolType = 0; //0 = AODV, 1 = DSDV, 2 = OLSR,  3 = DSR
int numberOfNodes;
std::string dataFileName = "output_data/test";
float xAxis = 0;

void SaveDataToFile(double pdr, double delay, double overhead, double avg_jitter, double average_throughput){
    std::fstream file;
    std::cout<<dataFileName + "_pdr.txt"<<std::endl;
    file.open(dataFileName + "_pdr.txt", std::ios_base::app);
    file << xAxis << " " << pdr << std::endl;
    file.close();

    file.open(dataFileName + "_delay.txt", std::ios_base::app);
    file << xAxis << " " << delay << std::endl;
    file.close();

    file.open(dataFileName + "_overhead.txt", std::ios_base::app);
    file << xAxis << " " << overhead << std::endl;
    file.close();
	
	  file.open(dataFileName + "_jitter.txt", std::ios_base::app);
    file << xAxis << " " << avg_jitter << std::endl;
    file.close();

    file.open(dataFileName + "_throughput.txt", std::ios_base::app);
    file << xAxis << " " << average_throughput << std::endl;
    file.close();
}

void IPV4PacketSent(std::string context, Ptr<const Packet> p, Ptr<Ipv4> ip, uint32_t a){
	//used to distinguish routing protocol packets from app packets
	if(std::find(app_packets.begin(), app_packets.end(), p->GetUid()) != app_packets.end()){
		//free space
		app_packets.remove(p->GetUid());

	}else{
		routing_packets_sent++;
	}
}

void SentPacket(std::string context, Ptr<const Packet> p){
    app_packets.push_back(p->GetUid());
    app_data_bytes_sent += p->GetSize(); 
    app_data_packets_sent++;
    delay_table.insert (std::make_pair (p->GetUid(), (double)Simulator::Now().GetSeconds()));
}
void ReceivedPacket(std::string context, Ptr<const Packet> p, const Address& addr){
    double temp = (double)Simulator::Now().GetSeconds();  
    std::map<uint32_t, double >::iterator i = delay_table.find ( p->GetUid() );
    if(i != delay_table.end()){ 
        double tempDelay = temp - i->second;
        average_delay += tempDelay;
        delay_table.erase(i);
        if(!first)jitter = tempDelay - last_delay;
        first = false;
        last_delay = tempDelay;
        sum_jitter += jitter;
    }
    app_data_bytes_received += p->GetSize(); 
    app_data_bytes_total += p->GetSize(); 
    app_data_packets_received++;
} 
void Ratio(){

    float pdr;
    float delay;
    float overhead;
	  double average_jitter = 0;
    double average_throughput = 0;

    pdr = (float)app_data_packets_received/(float)app_data_packets_sent;
    delay = (float) average_delay / (float) app_data_packets_received;
    overhead = (float)routing_packets_sent/(float)app_data_packets_sent;
    average_jitter = std::abs(sum_jitter/(float) app_data_packets_received);
    average_throughput = (float)app_data_bytes_received * 8/(numberOfApplications * 1000 * (float)(100-20));

    std::cout << "Sent (bytes):\t" <<  app_data_bytes_sent
    << "\tReceived (bytes):\t" << app_data_bytes_received 
    << "\nSent (Packets):\t" <<  app_data_packets_sent
    << "\nReceived (Packets):\t" << app_data_packets_received   
    << "\nPDR:\t" << pdr
    << "\nRouting packets sent (packets):\t" << routing_packets_sent
    << "\nNormalized routing overhead:\t" << overhead << "\n";
    if(app_data_packets_received > 0){
      std::cout << "AVG DELAY:\t" << delay << "\n"; //seconds
	    std::cout << "AVG JITTER:\t" << average_jitter << "\n"; //seconds
      std::cout << "AVG throughput:\t" << average_throughput << " Kbps" << "\n"; //seconds
    }

    SaveDataToFile(pdr, delay, overhead, average_jitter, average_throughput);
}


int random(int min, int max){  //range : [min, max)
   return min + rand() % (( max + 1 ) - min);
}
int main (int argc, char *argv[]){
  Packet::EnablePrinting(); 
  PacketMetadata::Enable ();

 
  
  uint32_t stream = 1;
  double simulationTime = 100;


  //mobility parameters
  double pauseTime = 0.0;
  double txpdistance = 150.0;

  CommandLine cmd;
  cmd.AddValue ("numberOfNodes", "numberOfNodes", numberOfNodes);
  cmd.AddValue ("routingProtocolType", "routingProtocolType", routingProtocolType);
  cmd.AddValue ("nodeSpeed", "nodeSpeed", nodeSpeed);
  cmd.AddValue ("proc", "proc", proc);

  cmd.AddValue ("dataFileName", "dataFileName", dataFileName);
  cmd.AddValue ("xAxis", "xAxis", xAxis);
  cmd.Parse (argc,argv);


  // BRITE needs a configuration file to build its graph. By default, this
  // example will use the TD_ASBarabasi_RTWaxman.conf file. There are many others
  // which can be found in the BRITE/conf_files directory

  
  std::string confFile = "scratch/TD_ASBarabasi_RTWaxman_" + std::to_string(numberOfNodes) +".conf";


  std::string rate = "0.5Mbps";
  std::string dataMode ("DsssRate11Mbps");
  std::string phyMode ("DsssRate11Mbps");

  
  // Invoke the BriteTopologyHelper and pass in a BRITE
  // configuration file and a seed file. This will use
  // BRITE to build a graph from which we can build the ns-3 topology
  BriteTopologyHelper bth (confFile);
  bth.AssignStreams (stream);
  ns3::RngSeedManager::SetSeed(100);
  RngSeedManager::SetRun (stream); 
  srand( stream ); //seeding for the first time only!
 



  InternetStackHelper stack; 
  
  //AODV, DSDV, OLSR, DSR
  if(routingProtocolType == 0){

      std::cout << "AODV routing protocol" << "\n";
      AodvHelper routingProtocol;
      stack.SetRoutingHelper (routingProtocol);

  }else if(routingProtocolType == 1){

      std::cout << "DSDV routing protocol" << "\n";
      DsdvHelper routingProtocol;
      stack.SetRoutingHelper (routingProtocol);

  }else if(routingProtocolType == 2){

      std::cout << "OLSR routing protocol" << "\n";
      OlsrHelper routingProtocol;
      stack.SetRoutingHelper (routingProtocol);

  }

  bth.BuildBriteTopology (stack);
  NS_LOG_INFO ("Number od nodes: "<< bth.GetNNodesTopology());

  NodeContainer nodes = NodeContainer();// = bth.FetchNodes();

  for (uint32_t  i = 0; i < bth.GetNNodesForAs(0); i++)
	nodes.Add(bth.GetNodeForAs(0, i));


  if(nodeSpeed > 0){

    MobilityHelper adhocMobility;
    ObjectFactory pos;
    pos.SetTypeId ("ns3::RandomRectanglePositionAllocator");
    pos.Set ("X", StringValue ("ns3::UniformRandomVariable[Min=0.0|Max=1000.0]"));
    pos.Set ("Y", StringValue ("ns3::UniformRandomVariable[Min=0.0|Max=1000.0]"));
    Ptr<PositionAllocator> taPositionAlloc = pos.Create ()->GetObject<PositionAllocator> ();

    std::ostringstream speedUniformRandomVariableStream;
    speedUniformRandomVariableStream << "ns3::UniformRandomVariable[Min=0.0|Max="
                                     << nodeSpeed
                                     << "]";

    std::ostringstream pauseConstantRandomVariableStream;
    pauseConstantRandomVariableStream << "ns3::ConstantRandomVariable[Constant="
                                      << pauseTime
                                      << "]";

    adhocMobility.SetMobilityModel ("ns3::RandomWaypointMobilityModel",
                                    "Speed", StringValue (speedUniformRandomVariableStream.str ()),
                                    "Pause", StringValue (pauseConstantRandomVariableStream.str ()),
                                    "PositionAllocator", PointerValue (taPositionAlloc)
                                    );
    adhocMobility.Install (nodes);

     
  }else{
   // bth.DefineNodeLocations();
  }


  numberOfApplications = nodes.GetN() * proc;

  NS_LOG_INFO ("setting the default phy and channel parameters ");
  WifiHelper wifi;
  wifi.SetStandard (WIFI_PHY_STANDARD_80211b);
  YansWifiPhyHelper wifiPhy = YansWifiPhyHelper::Default ();

  YansWifiChannelHelper wifiChannel;
  wifiChannel.SetPropagationDelay ("ns3::ConstantSpeedPropagationDelayModel");
  wifiChannel.AddPropagationLoss ("ns3::RangePropagationLossModel", "MaxRange", DoubleValue (txpdistance));
  wifiPhy.SetChannel (wifiChannel.Create ());

  // Add a mac and disable rate control
  WifiMacHelper wifiMac;
  wifi.SetRemoteStationManager (
    "ns3::ConstantRateWifiManager", "DataMode", 
    StringValue (dataMode), "ControlMode",
    StringValue (phyMode)
  );

  wifiMac.SetType ("ns3::AdhocWifiMac"); 
  NetDeviceContainer netDevices = wifi.Install (wifiPhy, wifiMac, nodes);
  if(routingProtocolType == 3){
    std::cout << "DSR routing protocol" << "\n"; 
   /* DsrHelper routingProtocol;
    stack.SetRoutingHelper(routingProtocol); */


    DsrMainHelper dsrMain;
    DsrHelper dsr;
    dsrMain.Install (dsr, nodes);
  }
  //wifiPhy.EnablePcapAll ("pcap_files/dsdv_ds-rt2019"); 

  // Set up Addresses
  Ipv4AddressHelper ipv4;
  NS_LOG_INFO ("Assign IP Addresses.");
  ipv4.SetBase ("10.1.1.0", "255.255.255.0");
  Ipv4InterfaceContainer ifcont = ipv4.Assign (netDevices);
  for(int a = 0; a < numberOfApplications; a++){

      uint16_t port = 8081+a;   // Discard port (RFC 863)
      uint16_t serverPosition = random( nodes.GetN()/2, nodes.GetN()-1 ) ; //bottom right
      uint16_t clientPosition = random( 0, nodes.GetN()/2 - 1 ) ; //top left

      Ptr<Node> client = nodes.Get(clientPosition);
      Ptr<Node> server = nodes.Get(serverPosition);

      OnOffHelper onoff ("ns3::UdpSocketFactory", InetSocketAddress (ifcont.GetAddress (serverPosition), port));
      onoff.SetConstantRate (DataRate ("512B/s"));

      ApplicationContainer apps = onoff.Install (nodes.Get (clientPosition));
      apps.Start (Seconds (20));
      apps.Stop (Seconds (simulationTime));

      // Create a packet sink to receive these packets
      PacketSinkHelper sinkHelper ("ns3::UdpSocketFactory", InetSocketAddress (Ipv4Address::GetAny (), port));
      ApplicationContainer sinkApp = sinkHelper.Install (nodes.Get (serverPosition));
      Ptr<PacketSink> sink = StaticCast<PacketSink> (sinkApp.Get (0));

      sinkApp.Start (Seconds (10));
      sinkApp.Stop (Seconds (simulationTime));

  }

  Config::Connect("/NodeList/*/ApplicationList/*/$ns3::PacketSink/Rx", MakeCallback(&ReceivedPacket));
  Config::Connect("/NodeList/*/ApplicationList/*/$ns3::OnOffApplication/Tx", MakeCallback(&SentPacket));

  Config::Connect("/NodeList/*/$ns3::Ipv4L3Protocol/Tx", MakeCallback(&IPV4PacketSent));


  NS_LOG_INFO ("Run Simulation."); 

 // AnimationInterface anim("dsr_brite.xml");
  Simulator::Stop (Seconds(simulationTime));
  Simulator::Run (); 
  Ratio();
  Simulator::Destroy ();
}

