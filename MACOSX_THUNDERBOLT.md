# Set up Thunderbolt Bridge

[headless Mac mini setup guide](https://astropad.com/blog/headless-mac-mini-setup-guide/).

- What Thunderbolt Bridge actually is
- When to use Thunderbolt vs WiFi
- How to setup Thunderbolt Bridge
- How to fix common connection issues related to Thunderbolt
- How to setup a static, or manual, IP address

## What is Thunderbolt Bridge?

Thunderbolt Bridge allows for high-speed data transfer between two devices using a Thunderbolt cable.

The Thunderbolt cable plugs into a compatible Thunderbolt port on each device, allowing you to share files, internet, and collaborate on workflows.

For example, products like [Luna Display](https://astropad.com/product/lunadisplay/) use Thunderbolt to turn your Mac or iPad into a second display and reduce latency when compared to a WiFi connection.

### Benefits of Thunderbolt Connections

#### **Backup and file transfer**

Thunderbolt Bridge makes data backup and syncing between Macs much faster. When using Migration Assistant to transfer files, apps, or settings to a new Mac, Thunderbolt is the best choice.

#### **Extended displays**

Apps like Luna Display use Thunderbolt to turn your Mac or iPad into a second display with better performance when comparing to wireless options.

🖥️ **Want to use your iMac as a monitor?** Check out our guide → [Use Your iMac as a Monitor: A Step-by-Step Guide](https://astropad.com/blog/step-by-step-guide-how-to-use-your-imac-as-a-monitor/)

#### **Internet sharing**

Share your internet connection from one Mac to another through Thunderbolt Bridge. This is especially helpful when only one Mac has network access.

#### **Real time collaboration**

Working with a teammate on a project? You can collaborate in real time by connecting two Macs with Thunderbolt, making team projects more productive.

## Thunderbolt vs WiFi: Which Works Best for You?

As convenient as WiFi can be, Thunderbolt Bridge has a clear advantage in speed and reliability.

### Advantages of Thunderbolt Bridge compared to WiFi

#### Security

Thunderbolt Bridge connections are harder to mess with and infiltrate. There are no wireless signals that hackers can snoop on and Thunderbolt cables also support encryption, which is perfect for sensitive files.

#### Works with more devices

If you have a Thunderbolt cable, you can connect a variety of things. From storage drives, displays, to audio equipment or even another computer with the help from Luna Display. This makes Thunderbolt useful for pro workflows, gaming setups, or media production.

#### **No interference**

WiFi can slow down when there’s interference from other networks, devices, or even Bluetooth. Thunderbolt is a direct cable connection, so you get consistent speed every time you connect without worry of inconsistent speeds.

#### **Expect way less lag**

This is huge if you’re using your Mac as a second display. Thunderbolt connections drop latency from around 25ms (on WiFi) down to 1-4ms with Luna Display. The difference in speeds is huge, especially for anything where responsiveness matters to you.

#### **When WiFi makes more sense** than Thunderbolt

That said, WiFi is easier if you’re just browsing or doing light file sharing and don’t want cables running between devices. Thunderbolt is worth it when speed and reliability actually matter to you.

## How to set up Thunderbolt Bridge on mac OS

Ready to get started? Here’s how to connect two Macs with Thunderbolt Bridge:

1. **Plug the Thunderbolt cable into both Macs**

Make sure you’re using the proper Thunderbolt ports on each computer
2. **Open System Settings on both Macs**

Note: Older macOS versions call this _System Preferences_ instead of System Settings
3. **Go to Network**

You’ll find this in the sidebar
4. **Look for Thunderbolt Bridge**

If you see a pop-up that says _New Interface Detected_, click _OK_.
5. **Check the status**

When Thunderbolt is working, you’ll see “Connected” or “Self-assigned IP” next to it. You’re good to go!

![](https://astropad.com/wp-content/uploads/2024/05/thunderbolt1-1-1024x841.webp)

**⚠️ Don’t see Thunderbolt Bridge?**

Click the Action menu (three dots) and select _**Add Service**_. Choose **_Thunderbolt Bridge_** from the Interface menu and click **_Create_**.

## **Troubleshooting Thunderbolt Connection Issues**

### How To Tell if Thunderbolt Isn’t Working

Here’s how to tell that something is wrong:

- Status shows as **Not Connected** or **Unknown State** in Network settings
- File transfers are really **slow or won’t start** at all
- You receive an error message stating **Cannot Use Thunderbolt Accessory** when plugging in your Thunderbolt cable. This usually means your cable isn’t actually a Thunderbolt cable or your device is having a hard time recognizing the cable altogether

**Check Your Cable**

Make sure you’re using a real Thunderbolt cable – it should have the Thunderbolt symbol (⚡) on the connector. Some USB-C cables look similar but won’t work for Thunderbolt connections.

![Make sure your cable is a true Thunderbolt cable in order to set up Thunderbolt Bridge](https://astropad.com/wp-content/uploads/2024/05/MD861_AV1-1024x838.webp)Make sure your cable is a true Thunderbolt cable in order to set up Thunderbolt Bridge

### **How to Fix “Not Connected”, “Unknown State”, or Thunderbolt Connection Issues with a Static IP Address**

If Thunderbolt shows “Not Connected” or “Unknown State,” it can often help to create a Static, or Manual, IP Address for your Thunderbolt connection. A static IP is one you assign yourself, it won’t change over time.

Here’s how to set it up:

1\. Open System **Settings** on both Macs and go to **Network**

2\. **Select Thunderbolt Bridge** and click **Details…**

![Click on Details.. to start setting up your Thunderbolt Bridge](https://astropad.com/wp-content/uploads/2024/05/static1-1-1024x926.webp)Click on Details.. to start setting up your Thunderbolt Bridge

3\. Go to the **TCP/IP tab** in the left-hand sidebar

![Click on TCP/IP and then Using DHCP to manually configure your Thunderbolt Bridge](https://astropad.com/wp-content/uploads/2024/05/static2-1024x926.webp)Click on TCP/IP and then Using DHCP to manually configure your Thunderbolt Bridge

4\. Change **“Configure IPv4”** to **Manually**

![Manually configure your Thunderbolt Bridge](https://astropad.com/wp-content/uploads/2024/05/static3.webp)Manually configure your Thunderbolt Bridge

5\. **Enter an IP address**

Static IPs for Thunderbolt typically start with `169.254.x.x`

For example:

**First Mac**: `169.254.1.1`

**Second Mac**: `169.254.1.2`

![Configure your Thunderbolt Bridge IP address here](https://astropad.com/wp-content/uploads/2024/05/static4-1024x926.webp)Configure your Thunderbolt Bridge IP address here

6\. Set the subnet mask to **`255.255.255.0`**

This needs to be the **same** on **both** Macs

7\. Click **Apply** and restart both computers

8\. **Check the status**

Thunderbolt Bridge should now show as **Self-assigned IP** or **Connected**

Need help with macOS settings? Check [Apple’s support guide](https://support.apple.com/guide/mac-help/) for more info.

* * *

### What’s Next?

Now you can use Thunderbolt Bridge for faster file transfers, working between Macs, or connecting a second display with Luna Display.

Learn more about Thunderbolt technology from Apple:

- [About Thunderbolt Pro cables](https://support.apple.com/en-us/118204)
- [About Adapters for Thunderbolt cables](https://support.apple.com/en-us/102477)

## Turn your Mac or iPad into a wireless second display

![](https://astropad.com/wp-content/uploads/2023/07/image-9.webp)[Luna Display](https://astropad.com/product/lunadisplay/) turns any Mac or iPad into a wireless second display

Luna Display lets you use any Mac or iPad as a wireless second screen. Check if it’s the right fit for you:

- **Mac or PC → iPad**: Extend your workspace onto your own iPad
- **Mac or PC → Mac**: Use your Mac as a secondary display (even older Macs 2012+)
- **Headless Mode**: Use your iPad or Mac as the main display for Mac mini, Mac Studio, or Mac Pro

