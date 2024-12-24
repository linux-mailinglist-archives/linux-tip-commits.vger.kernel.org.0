Return-Path: <linux-tip-commits+bounces-3122-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91D9FBBAE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DB616746A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57341DB52A;
	Tue, 24 Dec 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D57hA54P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwqvkyKt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB21B393D;
	Tue, 24 Dec 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033713; cv=none; b=R8h64YkuWy01VbGq+e4eWhSEVk0dgyFWFZ7jXTMwv84SGdXpTlVg6Hu/eITf1joMCLt9lzCk07O0PRb+ka7fZRb3TUw6HCKSHHECyPU5s37rZGfwodTqoA//Mv0KAa0PxZOqJcS3uq3Y4uImwh3gVesASVq/tOvXcnm8n/hxZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033713; c=relaxed/simple;
	bh=WTSmY3B0Gz0NCM7J/YtzrDZh/+QK56lUINfFDMQXzx0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=AeyqMmrqrx7e8WJ8x+x79XYxs5hqtRbONQQrfzha7dKFMIfbl2CmmZfweBIQjdCg+IwLd7VexyrlfBXCCgzhQ1TJBFCPtZ/SIFNO8VIWkAI/lfa269bnI7c86UwzkjquSUDlVLdlznjNLislonmfN0fOqNVO3XeGhsvDC7GIpsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D57hA54P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wwqvkyKt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=g/ZiZcqr2rPKu+//r8EQpGwy3zxpS8gvKVA7KM+TAdQ=;
	b=D57hA54PIbHF8jkhmlZUVhuCb3K0099gVsF5HvCnth6Hm74ukzFxcE0xPqctFeC4VF0B6d
	BPhMI+zh8zJh4JL4BxcvEqP2FcujdfkxxzIPkPXYKyjMk0F6q3VlB3LbSw/FBLINeP1J2M
	5TpKElRJ+Ors+5GgIicdplKgz6wgfwxiqY2s7yO0Lt2PlFNzTW1kAqAEC/PQ2uzrkmTzes
	jCenx+J78sD5vOve+VdfVYc+Es44MfaFCwULcUjInSfMqvy4sChHpfCr7HgR5C3Ac+DAC6
	ZO5W4bcpjaflPYgCmXP0TXrXOu4iTiGoJD1CtY1LqBMQ9hEs3T3k1KJLoDDrBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=g/ZiZcqr2rPKu+//r8EQpGwy3zxpS8gvKVA7KM+TAdQ=;
	b=wwqvkyKtWo1EsjTmO2w9DQTbeWpBb8YUuscwwy18sz77TsDOOpMgwg8UAiQJMbwQ01pkfc
	y/U0ywBeHRfz/aBg==
From: "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/tdx] x86/virt/tdx: Use auto-generated code to read global metadata
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kai Huang <kai.huang@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503370612.399.13925391126647774141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     04a7bc7316b8b9ea5564ea66eb65155203f1541f
Gitweb:        https://git.kernel.org/tip/04a7bc7316b8b9ea5564ea66eb65155203f1541f
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Sun, 15 Dec 2024 04:15:44 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 14:36:01 -08:00

x86/virt/tdx: Use auto-generated code to read global metadata

The TDX module provides a set of "Global Metadata Fields".  They report
things like TDX module version, supported features, and fields related
to create/run TDX guests and so on.

Currently the kernel only reads "TD Memory Region" (TDMR) related fields
for module initialization.  There are needs to read more global metadata
fields for future use:

 - Supported features ("TDX_FEATURES0") to fail module initialization
   when the module doesn't support "not clobbering host RBP when exiting
   from TDX guest" feature [1].
 - KVM TDX baseline support and other features like TDX Connect will
   need to read more.

The current global metadata reading code has limitations (e.g., it only
has a primitive helper to read metadata field with 16-bit element size,
while TDX supports 8/16/32/64 bits metadata element sizes).  It needs
tweaks in order to read more metadata fields.

But even with the tweaks, when new code is added to read a new field,
the reviewers will still need to review against the spec to make sure
the new code doesn't screw up things like using the wrong metadata
field ID (each metadata field is associated with a unique field ID,
which is a TDX-defined u64 constant) etc.

TDX documents all global metadata fields in a 'global_metadata.json'
file as part of TDX spec [2].  JSON format is machine readable.  Instead
of tweaking the metadata reading code, use a script to generate the code
so that:

  1) Using the generated C is simple.
  2) Adding a field is simple, e.g., the script just pulls the field ID
     out of the JSON for a given field thus no manual review is needed.

Specifically, to match the layout of the 'struct tdx_sys_info' and its
sub-structures, the script uses a table with each entry containing the
the name of the sub-structures (which reflects the "Class") and the
"Field Name" of all its fields, and auto-generate:

  1) The 'struct tdx_sys_info' and all 'struct tdx_sys_info_xx'
     sub-structures in 'tdx_global_metadata.h'.

  2) The main function 'get_tdx_sys_info()' which reads all metadata to
     'struct tdx_sys_info' and the 'get_tdx_sys_info_xx()' functions
     which read 'struct tdx_sys_info_xx()' in 'tdx_global_metadata.c'.

Using the generated C is simple: 1) include "tdx_global_metadata.h" to
the local "tdx.h"; 2) explicitly include "tdx_global_metadata.c" to the
local "tdx.c" after the read_sys_metadata_field() primitive (which is a
wrapper of TDH.SYS.RD SEAMCALL to read global metadata).

Adding a field is also simple: 1) just add the new field to an existing
structure, or add it with a new structure; 2) re-run the script to
generate the new code; 3) update the existing tdx_global_metadata.{hc}
with the new ones.

For now, use the auto-generated code to read the TDMR related fields and
the aforesaid metadata field "TDX_FEATURES0".

The tdx_global_metadata.{hc} can be generated by running below:

 #python tdx_global_metadata.py global_metadata.json \
	tdx_global_metadata.h tdx_global_metadata.c

.. where the 'global_metadata.json' can be fetched from [2] and the
'tdx_global_metadata.py' can be found from [3].

Co-developed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com/ [1]
Link: https://cdrdv2.intel.com/v1/dl/getContent/795381 [2]
Link: https://lore.kernel.org/762a50133300710771337398284567b299a86f67.camel@intel.com/ [3]
Link: https://lore.kernel.org/all/cbe3f12b1e5479399b53f4873f2ff783d9fc669b.1734188033.git.kai.huang%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 48 ++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.h | 25 ++++++++++-
 2 files changed, 73 insertions(+)
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c
 create mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.h

diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
new file mode 100644
index 0000000..8027a24
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Automatically generated functions to read TDX global metadata.
+ *
+ * This file doesn't compile on its own as it lacks of inclusion
+ * of SEAMCALL wrapper primitive which reads global metadata.
+ * Include this file to other C file instead.
+ */
+
+static int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x0A00000300000008, &val)))
+		sysinfo_features->tdx_features0 = val;
+
+	return ret;
+}
+
+static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
+		sysinfo_tdmr->max_tdmrs = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000009, &val)))
+		sysinfo_tdmr->max_reserved_per_tdmr = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000010, &val)))
+		sysinfo_tdmr->pamt_4k_entry_size = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000011, &val)))
+		sysinfo_tdmr->pamt_2m_entry_size = val;
+	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000012, &val)))
+		sysinfo_tdmr->pamt_1g_entry_size = val;
+
+	return ret;
+}
+
+static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
+{
+	int ret = 0;
+
+	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
+	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
+
+	return ret;
+}
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.h b/arch/x86/virt/vmx/tdx/tdx_global_metadata.h
new file mode 100644
index 0000000..6dd3c96
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Automatically generated TDX global metadata structures. */
+#ifndef _X86_VIRT_TDX_AUTO_GENERATED_TDX_GLOBAL_METADATA_H
+#define _X86_VIRT_TDX_AUTO_GENERATED_TDX_GLOBAL_METADATA_H
+
+#include <linux/types.h>
+
+struct tdx_sys_info_features {
+	u64 tdx_features0;
+};
+
+struct tdx_sys_info_tdmr {
+	u16 max_tdmrs;
+	u16 max_reserved_per_tdmr;
+	u16 pamt_4k_entry_size;
+	u16 pamt_2m_entry_size;
+	u16 pamt_1g_entry_size;
+};
+
+struct tdx_sys_info {
+	struct tdx_sys_info_features features;
+	struct tdx_sys_info_tdmr tdmr;
+};
+
+#endif

