Return-Path: <linux-tip-commits+bounces-6643-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9DFB59364
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB233B82B3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 10:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01CB3054E0;
	Tue, 16 Sep 2025 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYoWCt4q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOe3sqVS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526B304967;
	Tue, 16 Sep 2025 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018103; cv=none; b=Y/qp2bhii3WzJYoB+GpoPTzJ5ejACynYfABQEQwib+C9BSLr+pkBWdUzQ81pXIBUVai32Wukkiah3xX7Wl7VTgos0aJTEe2gCbAeLsdeL0FvREYgggp0HHxd1u8KpaeZkWUJLOKffto2AvChd8LCNOPR2Dy/KBUhoZNvc7bFA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018103; c=relaxed/simple;
	bh=cZJEWFUyL8WD+sduzD6djxXr8h8TLoX0QZllVYXxLCo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=V8n31MG8l3MjPyNLJmmZCit2uAzo8cGvcZc2JEo38qvNVwDGpt0ReeCV+cJi95ZuXhc94JMuB1WXbd5HZhZGmD38mjrq305q6ee9AWYeonJY3fMGiKeK7MqCMUqoMdCVES+zJInGEhX62vef4VBTxE0WSOlBaFRpWlLVRr/askk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYoWCt4q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOe3sqVS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 10:21:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758018100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kXeKxoJ/J/Zk0m1pNmG5YbQRiGBfEuu5SpjF0XxCxMU=;
	b=dYoWCt4q1RHaZ+3K4mqujFLWY+naIUsJdCTstivbgci34TMbcdd82YcTwvRCK8X4zFU3l2
	ZTgo+W0RPtRlBB+rF5rTnmLHIsR/ymoIdRdPD7WktynzIcOsgqh4Gtp+RBBr+4RBd7b5j2
	C/0vrGqvB2w+zI+pw94mNuW0WJfRxbX5fLGWT9K7jmVGpqvIF7jzZsmV719cc+EYvxDI4U
	PkJikVkQpyS/TA9fS+md3T/JwpklZGAbvS19fnPZQ6wHKFA1e/X1a6QSXYWddmKf4agBCB
	W9vpgtZQh3otRcSshvGgsU+ZHAbmPbTOVCV6BreD6fsYOZ0kpSzc3LYPPMf07g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758018100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kXeKxoJ/J/Zk0m1pNmG5YbQRiGBfEuu5SpjF0XxCxMU=;
	b=yOe3sqVSjmcFB9EM2QUIJWfLwLPtIl/W3q1hUJkOJX1Svb0Tpfqsjbn5133/OOJIkZAXKG
	pNSrQa2wl4KAmcAg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Rename and move CPU model entry for Diamond Rapids
Cc: Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175801809880.709179.13026933592926279814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     610c32025f510e2a9a161d55f60f1850d38fdb94
Gitweb:        https://git.kernel.org/tip/610c32025f510e2a9a161d55f60f1850d38=
fdb94
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 11 Aug 2025 14:33:45 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 14:17:18 +02:00

x86/cpu: Rename and move CPU model entry for Diamond Rapids

This model was added as INTEL_PANTHERCOVE_X (based on the name of the
core) with a comment that the platform name is Diamond Rapids. It was
also placed at the end of the file in a new section for family 19
processors.

This is different from previous naming. Andrew Cooper complained.
PeterZ agreed and posted a patch[1] to fix the name and move it in
sequence with other Xeon servers. But without a commit description or
sign-off the patch wasn't ever applied.

Patch updated to cover one additional use of the #define by turbostat
and to change the "Family 6" comment to also list 18 and 19 since new
models in these families are mixed in with family 6.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/all/20250214130205.GK14028@noisy.programming.ki=
cks-ass.net/ # [1]
---
 arch/x86/include/asm/intel-family.h                         | 7 +++----
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
 drivers/platform/x86/intel/tpmi_power_domains.c             | 2 +-
 tools/power/x86/turbostat/turbostat.c                       | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel=
-family.h
index e345dbd..f32a0ec 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -51,7 +51,7 @@
 #define INTEL_PENTIUM_MMX		IFM(5, 0x04) /* P55C */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
=20
-/* Family 6 */
+/* Family 6, 18, 19 */
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
 #define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
 #define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
@@ -126,6 +126,8 @@
 #define INTEL_GRANITERAPIDS_X		IFM(6, 0xAD) /* Redwood Cove */
 #define INTEL_GRANITERAPIDS_D		IFM(6, 0xAE)
=20
+#define INTEL_DIAMONDRAPIDS_X		IFM(19, 0x01) /* Panther Cove */
+
 #define INTEL_BARTLETTLAKE		IFM(6, 0xD7) /* Raptor Cove */
=20
 /* "Hybrid" Processors (P-Core/E-Core) */
@@ -203,9 +205,6 @@
 #define INTEL_P4_PRESCOTT_2M		IFM(15, 0x04)
 #define INTEL_P4_CEDARMILL		IFM(15, 0x06) /* Also Xeon Dempsey */
=20
-/* Family 19 */
-#define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
-
 /*
  * Intel CPU core types
  *
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/dr=
ivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 71e104a..7449873 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -790,7 +790,7 @@ static const struct x86_cpu_id isst_cpu_ids[] =3D {
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_ICELAKE_D,		0),
 	X86_MATCH_VFM(INTEL_ICELAKE_X,		0),
-	X86_MATCH_VFM(INTEL_PANTHERCOVE_X,	SST_HPM_SUPPORTED),
+	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X,	SST_HPM_SUPPORTED),
 	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	0),
 	X86_MATCH_VFM(INTEL_SKYLAKE_X,		SST_MBOX_SUPPORTED),
 	{}
diff --git a/drivers/platform/x86/intel/tpmi_power_domains.c b/drivers/platfo=
rm/x86/intel/tpmi_power_domains.c
index 8641353..7d93119 100644
--- a/drivers/platform/x86/intel/tpmi_power_domains.c
+++ b/drivers/platform/x86/intel/tpmi_power_domains.c
@@ -85,7 +85,7 @@ static const struct x86_cpu_id tpmi_cpu_ids[] =3D {
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	NULL),
 	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	NULL),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	NULL),
-	X86_MATCH_VFM(INTEL_PANTHERCOVE_X,	NULL),
+	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X,	NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, tpmi_cpu_ids);
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbosta=
t/turbostat.c
index 72a280e..47eb2d4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1195,7 +1195,7 @@ static const struct platform_data turbostat_pdata[] =3D=
 {
 	{ INTEL_EMERALDRAPIDS_X, &spr_features },
 	{ INTEL_GRANITERAPIDS_X, &spr_features },
 	{ INTEL_GRANITERAPIDS_D, &spr_features },
-	{ INTEL_PANTHERCOVE_X, &dmr_features },
+	{ INTEL_DIAMONDRAPIDS_X, &dmr_features },
 	{ INTEL_LAKEFIELD, &cnl_features },
 	{ INTEL_ALDERLAKE, &adl_features },
 	{ INTEL_ALDERLAKE_L, &adl_features },

