Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8B2B82D6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgKRRST (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgKRRST (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24418C0613D6;
        Wed, 18 Nov 2020 09:18:19 -0800 (PST)
Date:   Wed, 18 Nov 2020 17:18:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gd6XjJcJ/NmNjZlsPAEFluo/vMLxp7QLUG0TuxFSGU=;
        b=SHu3p5G8Dh84oPfjJf6OGwCe7yYLH4KT17cVYJZe73xJyw6VeZeIvQ+ikx2n6m3kEsRxGA
        OBSDyV5dsRQBZRw9HQzn/d1RA8Oz4nqoBM/5DS4+iRs9AVTYAPI8GnrWZbYlmtuCYVQZPv
        gMKURmlNp0ey3riijqpFEetaesfbYoechEU6OWmzCOcuRgPJ55OCRuLo+VEQLdH6JYkw3g
        A21a4VMkVaiIK0fO/VTOrdgJHLMdjc8MPnDvpx3KRnypIln5ujhyP653gkAPSbx7yF6i7H
        wpsmdDj6oL9O70HPPZLiCZ/en2ydlNHAULamQPZnaVsFucqBK+ypIhxJfGWGPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gd6XjJcJ/NmNjZlsPAEFluo/vMLxp7QLUG0TuxFSGU=;
        b=hVLN+2qrjAZrP7fjSKIdoBVbedkCTZjHhcKaboG0Sxg4PAV3sAVpSxK2UZZNQtsWYabhdO
        hUJ+W7V1dIxrINCQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] Documentation/x86: Document SGX kernel architecture
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        linux-doc@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-24-jarkko@kernel.org>
References: <20201112220135.165028-24-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571989677.11244.15978621394792313748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     3fa97bf001262a1d88ec9b4ac5ae6abe0ed1356c
Gitweb:        https://git.kernel.org/tip/3fa97bf001262a1d88ec9b4ac5ae6abe0ed=
1356c
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 00:01:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:16:13 +01:00

Documentation/x86: Document SGX kernel architecture

Document the Intel SGX kernel architecture. The fine-grained architecture
details can be looked up from Intel SDM Volume 3D.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Cc: linux-doc@vger.kernel.org
Link: https://lkml.kernel.org/r/20201112220135.165028-24-jarkko@kernel.org
---
 Documentation/x86/index.rst |   1 +-
 Documentation/x86/sgx.rst   | 211 +++++++++++++++++++++++++++++++++++-
 2 files changed, 212 insertions(+)
 create mode 100644 Documentation/x86/sgx.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index b224d12..647a570 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -33,3 +33,4 @@ x86-specific Documentation
    i386/index
    x86_64/index
    sva
+   sgx
diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
new file mode 100644
index 0000000..eaee136
--- /dev/null
+++ b/Documentation/x86/sgx.rst
@@ -0,0 +1,211 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+Software Guard eXtensions (SGX)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+Software Guard eXtensions (SGX) hardware enables for user space applications
+to set aside private memory regions of code and data:
+
+* Privileged (ring-0) ENCLS functions orchestrate the construction of the.
+  regions.
+* Unprivileged (ring-3) ENCLU functions allow an application to enter and
+  execute inside the regions.
+
+These memory regions are called enclaves. An enclave can be only entered at a
+fixed set of entry points. Each entry point can hold a single hardware thread
+at a time.  While the enclave is loaded from a regular binary file by using
+ENCLS functions, only the threads inside the enclave can access its memory. =
The
+region is denied from outside access by the CPU, and encrypted before it lea=
ves
+from LLC.
+
+The support can be determined by
+
+	``grep sgx /proc/cpuinfo``
+
+SGX must both be supported in the processor and enabled by the BIOS.  If SGX
+appears to be unsupported on a system which has hardware support, ensure
+support is enabled in the BIOS.  If a BIOS presents a choice between "Enable=
d"
+and "Software Enabled" modes for SGX, choose "Enabled".
+
+Enclave Page Cache
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+SGX utilizes an *Enclave Page Cache (EPC)* to store pages that are associated
+with an enclave. It is contained in a BIOS-reserved region of physical memor=
y.
+Unlike pages used for regular memory, pages can only be accessed from outsid=
e of
+the enclave during enclave construction with special, limited SGX instructio=
ns.
+
+Only a CPU executing inside an enclave can directly access enclave memory.
+However, a CPU executing inside an enclave may access normal memory outside =
the
+enclave.
+
+The kernel manages enclave memory similar to how it treats device memory.
+
+Enclave Page Types
+------------------
+
+**SGX Enclave Control Structure (SECS)**
+   Enclave's address range, attributes and other global data are defined
+   by this structure.
+
+**Regular (REG)**
+   Regular EPC pages contain the code and data of an enclave.
+
+**Thread Control Structure (TCS)**
+   Thread Control Structure pages define the entry points to an enclave and
+   track the execution state of an enclave thread.
+
+**Version Array (VA)**
+   Version Array pages contain 512 slots, each of which can contain a version
+   number for a page evicted from the EPC.
+
+Enclave Page Cache Map
+----------------------
+
+The processor tracks EPC pages in a hardware metadata structure called the
+*Enclave Page Cache Map (EPCM)*.  The EPCM contains an entry for each EPC pa=
ge
+which describes the owning enclave, access rights and page type among the ot=
her
+things.
+
+EPCM permissions are separate from the normal page tables.  This prevents the
+kernel from, for instance, allowing writes to data which an enclave wishes to
+remain read-only.  EPCM permissions may only impose additional restrictions =
on
+top of normal x86 page permissions.
+
+For all intents and purposes, the SGX architecture allows the processor to
+invalidate all EPCM entries at will.  This requires that software be prepare=
d to
+handle an EPCM fault at any time.  In practice, this can happen on events li=
ke
+power transitions when the ephemeral key that encrypts enclave memory is los=
t.
+
+Application interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Enclave build functions
+-----------------------
+
+In addition to the traditional compiler and linker build process, SGX has a
+separate enclave =E2=80=9Cbuild=E2=80=9D process.  Enclaves must be built be=
fore they can be
+executed (entered). The first step in building an enclave is opening the
+**/dev/sgx_enclave** device.  Since enclave memory is protected from direct
+access, special privileged instructions are Then used to copy data into encl=
ave
+pages and establish enclave page permissions.
+
+.. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
+   :functions: sgx_ioc_enclave_create
+               sgx_ioc_enclave_add_pages
+               sgx_ioc_enclave_init
+               sgx_ioc_enclave_provision
+
+Enclave vDSO
+------------
+
+Entering an enclave can only be done through SGX-specific EENTER and ERESUME
+functions, and is a non-trivial process.  Because of the complexity of
+transitioning to and from an enclave, enclaves typically utilize a library to
+handle the actual transitions.  This is roughly analogous to how glibc
+implementations are used by most applications to wrap system calls.
+
+Another crucial characteristic of enclaves is that they can generate excepti=
ons
+as part of their normal operation that need to be handled in the enclave or =
are
+unique to SGX.
+
+Instead of the traditional signal mechanism to handle these exceptions, SGX
+can leverage special exception fixup provided by the vDSO.  The kernel-provi=
ded
+vDSO function wraps low-level transitions to/from the enclave like EENTER and
+ERESUME.  The vDSO function intercepts exceptions that would otherwise gener=
ate
+a signal and return the fault information directly to its caller.  This avoi=
ds
+the need to juggle signal handlers.
+
+.. kernel-doc:: arch/x86/include/uapi/asm/sgx.h
+   :functions: vdso_sgx_enter_enclave_t
+
+ksgxd
+=3D=3D=3D=3D=3D
+
+SGX support includes a kernel thread called *ksgxwapd*.
+
+EPC sanitization
+----------------
+
+ksgxd is started when SGX initializes.  Enclave memory is typically ready
+For use when the processor powers on or resets.  However, if SGX has been in
+use since the reset, enclave pages may be in an inconsistent state.  This mi=
ght
+occur after a crash and kexec() cycle, for instance.  At boot, ksgxd
+reinitializes all enclave pages so that they can be allocated and re-used.
+
+The sanitization is done by going through EPC address space and applying the
+EREMOVE function to each physical page. Some enclave pages like SECS pages h=
ave
+hardware dependencies on other pages which prevents EREMOVE from functioning.
+Executing two EREMOVE passes removes the dependencies.
+
+Page reclaimer
+--------------
+
+Similar to the core kswapd, ksgxd, is responsible for managing the
+overcommitment of enclave memory.  If the system runs out of enclave memory,
+*ksgxwapd* =E2=80=9Cswaps=E2=80=9D enclave memory to normal memory.
+
+Launch Control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+SGX provides a launch control mechanism. After all enclave pages have been
+copied, kernel executes EINIT function, which initializes the enclave. Only =
after
+this the CPU can execute inside the enclave.
+
+ENIT function takes an RSA-3072 signature of the enclave measurement.  The f=
unction
+checks that the measurement is correct and signature is signed with the key
+hashed to the four **IA32_SGXLEPUBKEYHASH{0, 1, 2, 3}** MSRs representing the
+SHA256 of a public key.
+
+Those MSRs can be configured by the BIOS to be either readable or writable.
+Linux supports only writable configuration in order to give full control to =
the
+kernel on launch control policy. Before calling EINIT function, the driver s=
ets
+the MSRs to match the enclave's signing key.
+
+Encryption engines
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+In order to conceal the enclave data while it is out of the CPU package, the
+memory controller has an encryption engine to transparently encrypt and decr=
ypt
+enclave memory.
+
+In CPUs prior to Ice Lake, the Memory Encryption Engine (MEE) is used to
+encrypt pages leaving the CPU caches. MEE uses a n-ary Merkle tree with root=
 in
+SRAM to maintain integrity of the encrypted data. This provides integrity and
+anti-replay protection but does not scale to large memory sizes because the =
time
+required to update the Merkle tree grows logarithmically in relation to the
+memory size.
+
+CPUs starting from Icelake use Total Memory Encryption (TME) in the place of
+MEE. TME-based SGX implementations do not have an integrity Merkle tree, whi=
ch
+means integrity and replay-attacks are not mitigated.  B, it includes
+additional changes to prevent cipher text from being returned and SW memory
+aliases from being Created.
+
+DMA to enclave memory is blocked by range registers on both MEE and TME syst=
ems
+(SDM section 41.10).
+
+Usage Models
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Shared Library
+--------------
+
+Sensitive data and the code that acts on it is partitioned from the applicat=
ion
+into a separate library. The library is then linked as a DSO which can be lo=
aded
+into an enclave. The application can then make individual function calls into
+the enclave through special SGX instructions. A run-time within the enclave =
is
+configured to marshal function parameters into and out of the enclave and to
+call the correct library function.
+
+Application Container
+---------------------
+
+An application may be loaded into a container enclave which is specially
+configured with a library OS and run-time which permits the application to r=
un.
+The enclave run-time and library OS work together to execute the application
+when a thread enters the enclave.
