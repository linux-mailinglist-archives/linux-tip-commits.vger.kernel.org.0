Return-Path: <linux-tip-commits+bounces-6664-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FC6B801C4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 16:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08591C02C9D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55B2EB5CF;
	Wed, 17 Sep 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CSjDAE85";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VWtR7H2n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC56309EEE;
	Wed, 17 Sep 2025 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101270; cv=none; b=Fgdazj9QGe/GnwpouS/imm1MSfHrooh5IFAFC9zwvN3eIOzLyda7DgPtrm5e6aw6fJnxKA51Ij7Dwi6q1l3h4YJHzcR8mWYnb8bFfClPecrcnv5sE9LyZwFa7AYSx/opfOFaLcCChZxIMNY4KwUedM8LlT8p+Ff5lwugQPuuqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101270; c=relaxed/simple;
	bh=JXiJ59rp3E72QcuJq6CBf4fmi7QoXe5dWtyBefBiVPg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Il/7ZVEdl6gAgbVV9E9zcABPNP9lzlnIhrZ8FgsglBMWIgalav0zKcXeQdNYtGCkPZB9zjpxv3aFIr6tVoJcBhyLX9AwvwcWX6QPR2A25uq9U5kVKKzfQcerviDOCKlb88MTupqDDHRvnK1KnyBkiMavTLi6EQWOXwGpMvk4I9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CSjDAE85; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VWtR7H2n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 09:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758101266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=31HoQR5SlcfCLYEeC0C7tgycVNpdx9dWAbe/sRMWqKg=;
	b=CSjDAE85nc5KqnHnZ5Y3mu88sF7orWyL9V+U29KvIkXI+vRJ1wNJwM7LaT7LmIgX1S0cY9
	wgpWXo1FhjIsHCUZNaAjU3JdbZGp4LUfjPjd7ElvOKsxHysxbX9kH4+wRCswLLourQiAPV
	6/varSSlperpHiea++gDPTDdx+FvDSp9T4grWFazwo0FpDRUwkrg02qyE+TCQT8kGJvGkg
	fWaiwCJQfsuifX7h4hkmgexho3qQM0+dblo3QIAuK6YpscttedtJJ9+YpNISwi02WPe7K1
	FrwPgHrdLNLypsHccjJ21aKQ8DIS31jL2ACj9UPbxV2ixS7l1kXD51SMy8AgCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758101266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=31HoQR5SlcfCLYEeC0C7tgycVNpdx9dWAbe/sRMWqKg=;
	b=VWtR7H2nAxlaHIr+8eOoEc8dtpdP0V3ifU3cpyoYvexvJWmwpX7ozsDpVNHjBThxtz7RHT
	zGKI0Uv4rnZyp4Dg==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] Documentation/x86/topology: Detail CPUID leaves used
 for topology enumeration
Cc: Borislav Petkov <bp@alien8.de>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175810126453.709179.14501505317220246384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d98b40c07552a3bdc72bfc5879748707ba7598ae
Gitweb:        https://git.kernel.org/tip/d98b40c07552a3bdc72bfc5879748707ba7=
598ae
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 01 Sep 2025 17:04:18=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Sep 2025 11:24:54 +02:00

Documentation/x86/topology: Detail CPUID leaves used for topology enumeration

Add a new section describing the different CPUID leaves and fields used
to parse topology on x86 systems.

  [ bp: Cleanups and simplifications ontop. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

