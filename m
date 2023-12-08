Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686FA80AA60
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjLHRRP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 Dec 2023 12:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjLHRRO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 Dec 2023 12:17:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6576F11D;
        Fri,  8 Dec 2023 09:17:19 -0800 (PST)
Date:   Fri, 08 Dec 2023 17:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702055838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0RxA+6PGsSc16bQMnDfK55gsUCFDNIAinB7xSpgG6Eo=;
        b=ehuyWzP4ozxC6qgoU5fr55bRS4211SBNvMJBJn0+PXBGlNws1CXAkspMzMWbySjXLAz503
        HD9OjlRLglep31TBdV0ZELhzu8nlCI5eJHtK+PmZCtu0HfVVOtEJjZ69j3BQCW9+953RZL
        4nt8/0mOIUBKd0qw1PZBKkOX9xSr5Pal0rK1/XDbfxiyrG4jHL2xcSMp6UgmwWWkuNuRzK
        TiUws3WuPnmZauTGwGWNR4RVrYwTEDcMcXo4/7PXoHVw0952CFCsyAvOZDV7+NN6Ay26IA
        7I8H0si/8gkxnPrwzxytm/XdL3hjP/yhSAJUzbZCXlmcKYFPewg/zC4CWxYSFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702055838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0RxA+6PGsSc16bQMnDfK55gsUCFDNIAinB7xSpgG6Eo=;
        b=/gOUJ4ht/VKGxNLmPsLROrdF33rRdkQUul2PSJJoK8fxxsGzjFryOzvRce8tZTQ7ByXUmR
        2hSJ74eavaRE84Dw==
From:   "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] Documentation/x86: Add documentation for TDX host support
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205583733.398.17710078331080073103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     c1759937f488fc5f05304090720d8851abfb49e0
Gitweb:        https://git.kernel.org/tip/c1759937f488fc5f05304090720d8851abfb49e0
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:39 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 09:12:52 -08:00

Documentation/x86: Add documentation for TDX host support

Add documentation for TDX host kernel support.  There is already one
file Documentation/x86/tdx.rst containing documentation for TDX guest
internals.  Also reuse it for TDX host kernel support.

Introduce a new level menu "TDX Guest Support" and move existing
materials under it, and add a new menu for TDX host kernel support.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-19-dave.hansen%40intel.com
---
 Documentation/arch/x86/tdx.rst | 207 ++++++++++++++++++++++++++++++--
 1 file changed, 196 insertions(+), 11 deletions(-)

diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index dc8d9fd..719043c 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -10,6 +10,191 @@ encrypting the guest memory. In TDX, a special module running in a special
 mode sits between the host and the guest and manages the guest/host
 separation.
 
+TDX Host Kernel Support
+=======================
+
+TDX introduces a new CPU mode called Secure Arbitration Mode (SEAM) and
+a new isolated range pointed by the SEAM Ranger Register (SEAMRR).  A
+CPU-attested software module called 'the TDX module' runs inside the new
+isolated range to provide the functionalities to manage and run protected
+VMs.
+
+TDX also leverages Intel Multi-Key Total Memory Encryption (MKTME) to
+provide crypto-protection to the VMs.  TDX reserves part of MKTME KeyIDs
+as TDX private KeyIDs, which are only accessible within the SEAM mode.
+BIOS is responsible for partitioning legacy MKTME KeyIDs and TDX KeyIDs.
+
+Before the TDX module can be used to create and run protected VMs, it
+must be loaded into the isolated range and properly initialized.  The TDX
+architecture doesn't require the BIOS to load the TDX module, but the
+kernel assumes it is loaded by the BIOS.
+
+TDX boot-time detection
+-----------------------
+
+The kernel detects TDX by detecting TDX private KeyIDs during kernel
+boot.  Below dmesg shows when TDX is enabled by BIOS::
+
+  [..] virt/tdx: BIOS enabled: private KeyID range: [16, 64)
+
+TDX module initialization
+---------------------------------------
+
+The kernel talks to the TDX module via the new SEAMCALL instruction.  The
+TDX module implements SEAMCALL leaf functions to allow the kernel to
+initialize it.
+
+If the TDX module isn't loaded, the SEAMCALL instruction fails with a
+special error.  In this case the kernel fails the module initialization
+and reports the module isn't loaded::
+
+  [..] virt/tdx: module not loaded
+
+Initializing the TDX module consumes roughly ~1/256th system RAM size to
+use it as 'metadata' for the TDX memory.  It also takes additional CPU
+time to initialize those metadata along with the TDX module itself.  Both
+are not trivial.  The kernel initializes the TDX module at runtime on
+demand.
+
+Besides initializing the TDX module, a per-cpu initialization SEAMCALL
+must be done on one cpu before any other SEAMCALLs can be made on that
+cpu.
+
+The kernel provides two functions, tdx_enable() and tdx_cpu_enable() to
+allow the user of TDX to enable the TDX module and enable TDX on local
+cpu respectively.
+
+Making SEAMCALL requires VMXON has been done on that CPU.  Currently only
+KVM implements VMXON.  For now both tdx_enable() and tdx_cpu_enable()
+don't do VMXON internally (not trivial), but depends on the caller to
+guarantee that.
+
+To enable TDX, the caller of TDX should: 1) temporarily disable CPU
+hotplug; 2) do VMXON and tdx_enable_cpu() on all online cpus; 3) call
+tdx_enable().  For example::
+
+        cpus_read_lock();
+        on_each_cpu(vmxon_and_tdx_cpu_enable());
+        ret = tdx_enable();
+        cpus_read_unlock();
+        if (ret)
+                goto no_tdx;
+        // TDX is ready to use
+
+And the caller of TDX must guarantee the tdx_cpu_enable() has been
+successfully done on any cpu before it wants to run any other SEAMCALL.
+A typical usage is do both VMXON and tdx_cpu_enable() in CPU hotplug
+online callback, and refuse to online if tdx_cpu_enable() fails.
+
+User can consult dmesg to see whether the TDX module has been initialized.
+
+If the TDX module is initialized successfully, dmesg shows something
+like below::
+
+  [..] virt/tdx: 262668 KBs allocated for PAMT
+  [..] virt/tdx: module initialized
+
+If the TDX module failed to initialize, dmesg also shows it failed to
+initialize::
+
+  [..] virt/tdx: module initialization failed ...
+
+TDX Interaction to Other Kernel Components
+------------------------------------------
+
+TDX Memory Policy
+~~~~~~~~~~~~~~~~~
+
+TDX reports a list of "Convertible Memory Region" (CMR) to tell the
+kernel which memory is TDX compatible.  The kernel needs to build a list
+of memory regions (out of CMRs) as "TDX-usable" memory and pass those
+regions to the TDX module.  Once this is done, those "TDX-usable" memory
+regions are fixed during module's lifetime.
+
+To keep things simple, currently the kernel simply guarantees all pages
+in the page allocator are TDX memory.  Specifically, the kernel uses all
+system memory in the core-mm "at the time of TDX module initialization"
+as TDX memory, and in the meantime, refuses to online any non-TDX-memory
+in the memory hotplug.
+
+Physical Memory Hotplug
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Note TDX assumes convertible memory is always physically present during
+machine's runtime.  A non-buggy BIOS should never support hot-removal of
+any convertible memory.  This implementation doesn't handle ACPI memory
+removal but depends on the BIOS to behave correctly.
+
+CPU Hotplug
+~~~~~~~~~~~
+
+TDX module requires the per-cpu initialization SEAMCALL must be done on
+one cpu before any other SEAMCALLs can be made on that cpu.  The kernel
+provides tdx_cpu_enable() to let the user of TDX to do it when the user
+wants to use a new cpu for TDX task.
+
+TDX doesn't support physical (ACPI) CPU hotplug.  During machine boot,
+TDX verifies all boot-time present logical CPUs are TDX compatible before
+enabling TDX.  A non-buggy BIOS should never support hot-add/removal of
+physical CPU.  Currently the kernel doesn't handle physical CPU hotplug,
+but depends on the BIOS to behave correctly.
+
+Note TDX works with CPU logical online/offline, thus the kernel still
+allows to offline logical CPU and online it again.
+
+Kexec()
+~~~~~~~
+
+TDX host support currently lacks the ability to handle kexec.  For
+simplicity only one of them can be enabled in the Kconfig.  This will be
+fixed in the future.
+
+Erratum
+~~~~~~~
+
+The first few generations of TDX hardware have an erratum.  A partial
+write to a TDX private memory cacheline will silently "poison" the
+line.  Subsequent reads will consume the poison and generate a machine
+check.
+
+A partial write is a memory write where a write transaction of less than
+cacheline lands at the memory controller.  The CPU does these via
+non-temporal write instructions (like MOVNTI), or through UC/WC memory
+mappings.  Devices can also do partial writes via DMA.
+
+Theoretically, a kernel bug could do partial write to TDX private memory
+and trigger unexpected machine check.  What's more, the machine check
+code will present these as "Hardware error" when they were, in fact, a
+software-triggered issue.  But in the end, this issue is hard to trigger.
+
+If the platform has such erratum, the kernel prints additional message in
+machine check handler to tell user the machine check may be caused by
+kernel bug on TDX private memory.
+
+Interaction vs S3 and deeper states
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+TDX cannot survive from S3 and deeper states.  The hardware resets and
+disables TDX completely when platform goes to S3 and deeper.  Both TDX
+guests and the TDX module get destroyed permanently.
+
+The kernel uses S3 for suspend-to-ram, and use S4 and deeper states for
+hibernation.  Currently, for simplicity, the kernel chooses to make TDX
+mutually exclusive with S3 and hibernation.
+
+The kernel disables TDX during early boot when hibernation support is
+available::
+
+  [..] virt/tdx: initialization failed: Hibernation support is enabled
+
+Add 'nohibernate' kernel command line to disable hibernation in order to
+use TDX.
+
+ACPI S3 is disabled during kernel early boot if TDX is enabled.  The user
+needs to turn off TDX in the BIOS in order to use S3.
+
+TDX Guest Support
+=================
 Since the host cannot directly access guest registers or memory, much
 normal functionality of a hypervisor must be moved into the guest. This is
 implemented using a Virtualization Exception (#VE) that is handled by the
@@ -20,7 +205,7 @@ TDX includes new hypercall-like mechanisms for communicating from the
 guest to the hypervisor or the TDX module.
 
 New TDX Exceptions
-==================
+------------------
 
 TDX guests behave differently from bare-metal and traditional VMX guests.
 In TDX guests, otherwise normal instructions or memory accesses can cause
@@ -30,7 +215,7 @@ Instructions marked with an '*' conditionally cause exceptions.  The
 details for these instructions are discussed below.
 
 Instruction-based #VE
----------------------
+~~~~~~~~~~~~~~~~~~~~~
 
 - Port I/O (INS, OUTS, IN, OUT)
 - HLT
@@ -41,7 +226,7 @@ Instruction-based #VE
 - CPUID*
 
 Instruction-based #GP
----------------------
+~~~~~~~~~~~~~~~~~~~~~
 
 - All VMX instructions: INVEPT, INVVPID, VMCLEAR, VMFUNC, VMLAUNCH,
   VMPTRLD, VMPTRST, VMREAD, VMRESUME, VMWRITE, VMXOFF, VMXON
@@ -52,7 +237,7 @@ Instruction-based #GP
 - RDMSR*,WRMSR*
 
 RDMSR/WRMSR Behavior
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
 MSR access behavior falls into three categories:
 
@@ -73,7 +258,7 @@ trapping and handling in the TDX module.  Other than possibly being slow,
 these MSRs appear to function just as they would on bare metal.
 
 CPUID Behavior
---------------
+~~~~~~~~~~~~~~
 
 For some CPUID leaves and sub-leaves, the virtualized bit fields of CPUID
 return values (in guest EAX/EBX/ECX/EDX) are configurable by the
@@ -93,7 +278,7 @@ not know how to handle. The guest kernel may ask the hypervisor for the
 value with a hypercall.
 
 #VE on Memory Accesses
-======================
+----------------------
 
 There are essentially two classes of TDX memory: private and shared.
 Private memory receives full TDX protections.  Its content is protected
@@ -107,7 +292,7 @@ entries.  This helps ensure that a guest does not place sensitive
 information in shared memory, exposing it to the untrusted hypervisor.
 
 #VE on Shared Memory
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
 Access to shared mappings can cause a #VE.  The hypervisor ultimately
 controls whether a shared memory access causes a #VE, so the guest must be
@@ -127,7 +312,7 @@ be careful not to access device MMIO regions unless it is also prepared to
 handle a #VE.
 
 #VE on Private Pages
---------------------
+~~~~~~~~~~~~~~~~~~~~
 
 An access to private mappings can also cause a #VE.  Since all kernel
 memory is also private memory, the kernel might theoretically need to
@@ -145,7 +330,7 @@ The hypervisor is permitted to unilaterally move accepted pages to a
 to handle the exception.
 
 Linux #VE handler
-=================
+-----------------
 
 Just like page faults or #GP's, #VE exceptions can be either handled or be
 fatal.  Typically, an unhandled userspace #VE results in a SIGSEGV.
@@ -167,7 +352,7 @@ While the block is in place, any #VE is elevated to a double fault (#DF)
 which is not recoverable.
 
 MMIO handling
-=============
+-------------
 
 In non-TDX VMs, MMIO is usually implemented by giving a guest access to a
 mapping which will cause a VMEXIT on access, and then the hypervisor
@@ -189,7 +374,7 @@ MMIO access via other means (like structure overlays) may result in an
 oops.
 
 Shared Memory Conversions
-=========================
+-------------------------
 
 All TDX guest memory starts out as private at boot.  This memory can not
 be accessed by the hypervisor.  However, some kernel users like device
