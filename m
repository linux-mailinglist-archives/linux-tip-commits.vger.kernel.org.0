Return-Path: <linux-tip-commits+bounces-6639-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1856AB59355
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01AC57AD3AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E792F83B8;
	Tue, 16 Sep 2025 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5Bh++PK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKmjDeIF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2735283FD8;
	Tue, 16 Sep 2025 10:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018099; cv=none; b=Krda2IZWf0njrDEUe5042L7KxvDJOZQckhJe939BguX6gX8zPa8y0A0ncQnFksW7Zgqe8s1U/J57UbhqPclejx3bLCfULDQLndMdt/ypD5ayYxHfcqoau0ge09pWH5VLg2BX3AYM7MTfsxyzmhQvwCG4ZBS2QRX/yqR0t48WMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018099; c=relaxed/simple;
	bh=+yOnLdILGRfEFfDrwOoOd2rkBE5fOPGoAMnO4Qwb8OA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bx8CZWwvW8kTubIzhKuZtAcQZcd6ML5yWOW48JgPOzk0ieGW4EBfHyCmsxY1UbevGrvi9YLKCpPNxOQtYqbEq8Flh4Hx74SsXfZ3lWEdGJA5ylt/BmC46Y8vmyifXGqJ79hl2bYLNvFO6lHIKmPiDXGZwJfJ0dWdS7R7xFZw20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d5Bh++PK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKmjDeIF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 10:21:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758018095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2RJQxI6IuWp8iZtz+h/ZLksFF5jSNxyG++Z3VG1/LbY=;
	b=d5Bh++PKaMkUscRhhAC3U3TDaNBAdktMIufoYLr9c/+xgp06P2yruickezRlJRGGT8f0ox
	Mg8/tCI89KrI/dws4OYd8mu1ZE1/JhxczcSVumhyj2sHkpfv8Qk8GBO+9owi4CdP7d2VPX
	qsRlri9rw21u8LL3YiL2KpzGpCASw35gZQZ2Arep5GGYx74TZBcftbUvFBOU2Qi4nXuxNT
	K9RWHBYWLWDVCXVeW6fpifz6V5YCJtvfb+yP9jxB4NYyZJnBotRUjXVszjZFFmu4DOEUgp
	s4Prc4THLDXijCtEdVnt8Vp4rIdAf4s78Uzc39ZfO/7wAlSDHC+dIKZN2eBZ2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758018095;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=2RJQxI6IuWp8iZtz+h/ZLksFF5jSNxyG++Z3VG1/LbY=;
	b=LKmjDeIF0Yor2Cy+/o5djI4D16FkjVwhqdOnoQDqSByWMXpkAvAF1gh+pbEgdbCKbqTdzU
	JFoqiYcsob5gOzDg==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] Documentation/x86/topology: Detail CPUID leaves used
 for topology enumeration
Cc: Borislav Petkov <bp@alien8.de>, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175801809383.709179.5867646440147455376.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c3ebd1304f12a7103ae1b0a07066d6b420151ba1
Gitweb:        https://git.kernel.org/tip/c3ebd1304f12a7103ae1b0a07066d6b4201=
51ba1
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 01 Sep 2025 17:04:18=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 15:42:56 +02:00

Documentation/x86/topology: Detail CPUID leaves used for topology enumeration

Add a new section describing the different CPUID leaves and fields used
to parse topology on x86 systems.

  [ bp: Cleanups and simplifications ontop. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250901170418.4314-1-kprateek.nayak@amd.com
---
 Documentation/arch/x86/topology.rst | 191 +++++++++++++++++++++++++++-
 1 file changed, 191 insertions(+)

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/top=
ology.rst
index c12837e..86bec8a 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -141,6 +141,197 @@ Thread-related topology information in the kernel:
=20
=20
=20
+System topology enumeration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+The topology on x86 systems can be discovered using a combination of vendor
+specific CPUID leaves which enumerate the processor topology and the cache
+hierarchy.
+
+The CPUID leaves in their preferred order of parsing for each x86 vendor is =
as
+follows:
+
+1) AMD
+
+   1) CPUID leaf 0x80000026 [Extended CPU Topology] (Core::X86::Cpuid::ExCpu=
Topology)
+
+      The extended CPUID leaf 0x80000026 is the extension of the CPUID leaf =
0xB
+      and provides the topology information of Core, Complex, CCD (Die), and
+      Socket in each level.
+
+      Support for the leaf is discovered by checking if the maximum extended
+      CPUID level is >=3D 0x80000026 and then checking if `LogProcAtThisLeve=
l`
+      in `EBX[15:0]` at a particular level (starting from 0) is non-zero.
+
+      The `LevelType` in `ECX[15:8]` at the level provides the topology doma=
in
+      the level describes - Core, Complex, CCD(Die), or the Socket.
+
+      The kernel uses the `CoreMaskWidth` from `EAX[4:0]` to discover the
+      number of bits that need to be right-shifted from `ExtendedLocalApicId`
+      in `EDX[31:0]` in order to get a unique Topology ID for the topology=20
+      level. CPUs with the same Topology ID share the resources at that leve=
l.
+
+      CPUID leaf 0x80000026 also provides more information regarding the pow=
er
+      and efficiency rankings, and about the core type on AMD processors with
+      heterogeneous characteristics.
+
+      If CPUID leaf 0x80000026 is supported, further parsing is not required.
+
+   2) CPUID leaf 0x0000000B [Extended Topology Enumeration] (Core::X86::Cpui=
d::ExtTopEnum)
+
+      The extended CPUID leaf 0x0000000B is the predecessor on the extended
+      CPUID leaf 0x80000026 and only describes the core, and the socket doma=
ins
+      of the processor topology.
+
+      The support for the leaf is discovered by checking if the maximum supp=
orted
+      CPUID level is >=3D 0xB and then if `EBX[31:0]` at a particular level
+      (starting from 0) is non-zero.
+
+      The `LevelType` in `ECX[15:8]` at the level provides the topology doma=
in
+      that the level describes - Thread, or Processor (Socket).
+
+      The kernel uses the `CoreMaskWidth` from `EAX[4:0]` to discover the
+      number of bits that need to be right-shifted from the `ExtendedLocalAp=
icId`
+      in `EDX[31:0]` to get a unique Topology ID for that topology level. CP=
Us
+      sharing the Topology ID share the resources at that level.
+
+      If CPUID leaf 0xB is supported, further parsing is not required.
+
+
+   3) CPUID leaf 0x80000008 ECX [Size Identifiers] (Core::X86::Cpuid::SizeId)
+
+      If neither the CPUID leaf 0x80000026 nor 0xB is supported, the number =
of
+      CPUs on the package is detected using the Size Identifier leaf
+      0x80000008 ECX.
+
+      The support for the leaf is discovered by checking if the supported
+      extended CPUID level is >=3D 0x80000008.
+
+      The shifts from the APIC ID for the Socket ID is calculated from the
+      `ApicIdSize` field in `ECX[15:12]` if it is non-zero.
+
+      If `ApicIdSize` is reported to be zero, the shift is calculated as the
+      order of the `number of threads` calculated from `NC` field in
+      `ECX[7:0]` which describes the `number of threads - 1` on the package.
+
+      Unless Extended APIC ID is supported, the APIC ID used to find the
+      Socket ID is from the `LocalApicId` field of CPUID leaf 0x00000001
+      `EBX[31:24]`.
+
+      The topology parsing continues to detect if Extended APIC ID is
+      supported or not.
+
+
+   4) CPUID leaf 0x8000001E [Extended APIC ID, Core Identifiers, Node Identi=
fiers]
+      (Core::X86::Cpuid::{ExtApicId,CoreId,NodeId})
+
+      The support for Extended APIC ID can be detected by checking for the
+      presence of `TopologyExtensions` in `ECX[22]` of CPUID leaf 0x80000001
+      [Feature Identifiers] (Core::X86::Cpuid::FeatureExtIdEcx).
+
+      If Topology Extensions is supported, the APIC ID from `ExtendedApicId`
+      from CPUID leaf 0x8000001E `EAX[31:0]` should be preferred over that f=
rom
+      `LocalApicId` field of CPUID leaf 0x00000001 `EBX[31:24]` for topology
+      enumeration.
+
+      On processors of Family 0x17 and above that do not support CPUID leaf
+      0x80000026 or CPUID leaf 0xB, the shifts from the APIC ID for the Core
+      ID is calculated using the order of `number of threads per core`
+      calculated using the `ThreadsPerCore` field in `EBX[15:8]` which
+      describes `number of threads per core - 1`.
+
+      On Processors of Family 0x15, the Core ID from `EBX[7:0]` is used as t=
he
+      `cu_id` (Compute Unit ID) to detect CPUs that share the compute units.
+
+
+   All AMD processors that support the `TopologyExtensions` feature store the
+   `NodeId` from the `ECX[7:0]` of CPUID leaf 0x8000001E=20
+   (Core::X86::Cpuid::NodeId) as the per-CPU `node_id`. On older processors,
+   the `node_id` was discovered using MSR_FAM10H_NODE_ID MSR (MSR
+   0x0xc001_100c). The presence of the NODE_ID MSR was detected by checking
+   `ECX[19]` of CPUID leaf 0x80000001 [Feature Identifiers]
+   (Core::X86::Cpuid::FeatureExtIdEcx).
+
+
+2) Intel
+
+   On Intel platforms, the CPUID leaves that enumerate the processor
+   topology are as follows:
+
+   1) CPUID leaf 0x1F (V2 Extended Topology Enumeration Leaf)
+
+      The CPUID leaf 0x1F is the extension of the CPUID leaf 0xB and provides
+      the topology information of Core, Module, Tile, Die, DieGrp, and Socket
+      in each level.
+
+      The support for the leaf is discovered by checking if the supported
+      CPUID level is >=3D 0x1F and then `EBX[31:0]` at a particular level
+      (starting from 0) is non-zero.
+
+      The `Domain Type` in `ECX[15:8]` of the sub-leaf provides the topology
+      domain that the level describes - Core, Module, Tile, Die, DieGrp, and
+      Socket.
+
+      The kernel uses the value from `EAX[4:0]` to discover the number of
+      bits that need to be right shifted from the `x2APIC ID` in `EDX[31:0]`
+      to get a unique Topology ID for the topology level. CPUs with the same
+      Topology ID share the resources at that level.
+
+      If CPUID leaf 0x1F is supported, further parsing is not required.
+
+
+   2) CPUID leaf 0x0000000B (Extended Topology Enumeration Leaf)
+
+      The extended CPUID leaf 0x0000000B is the predecessor of the V2 Extend=
ed
+      Topology Enumeration Leaf 0x1F and only describes the core, and the
+      socket domains of the processor topology.
+
+      The support for the leaf is iscovered by checking if the supported CPU=
ID
+      level is >=3D 0xB and then checking if `EBX[31:0]` at a particular lev=
el
+      (starting from 0) is non-zero.
+
+      CPUID leaf 0x0000000B shares the same layout as CPUID leaf 0x1F and
+      should be enumerated in a similar manner.
+
+      If CPUID leaf 0xB is supported, further parsing is not required.
+
+
+   3) CPUID leaf 0x00000004 (Deterministic Cache Parameters Leaf)
+
+      On Intel processors that support neither CPUID leaf 0x1F, nor CPUID le=
af
+      0xB, the shifts for the SMT domains is calculated using the number of
+      CPUs sharing the L1 cache.
+
+      Processors that feature Hyper-Threading is detected using `EDX[28]` of
+      CPUID leaf 0x1 (Basic CPUID Information).
+
+      The order of `Maximum number of addressable IDs for logical processors
+      sharing this cache` from `EAX[25:14]` of level-0 of CPUID 0x4 provides
+      the shifts from the APIC ID required to compute the Core ID.
+
+      The APIC ID and Package information is computed using the data from
+      CPUID leaf 0x1.
+
+
+   4) CPUID leaf 0x00000001 (Basic CPUID Information)
+
+      The mask and shifts to derive the Physical Package (socket) ID is
+      computed using the `Maximum number of addressable IDs for logical
+      processors in this physical package` from `EBX[23:16]` of CPUID leaf
+      0x1.
+
+     The APIC ID on the legacy platforms is derived from the `Initial APIC
+     ID` field from `EBX[31:24]` of CPUID leaf 0x1.
+
+
+3) Centaur and Zhaoxin
+
+   Similar to Intel, Centaur and Zhaoxin use a combination of CPUID leaf
+   0x00000004 (Deterministic Cache Parameters Leaf) and CPUID leaf 0x00000001
+   (Basic CPUID Information) to derive the topology information.
+
+
+
 System topology examples
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20

