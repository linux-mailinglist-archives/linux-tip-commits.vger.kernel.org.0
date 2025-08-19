Return-Path: <linux-tip-commits+bounces-6284-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC81B2D023
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 01:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFCA1C275A5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Aug 2025 23:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224D26F2A9;
	Tue, 19 Aug 2025 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DvzsoGvp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8iG7PUeS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43821883E;
	Tue, 19 Aug 2025 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755646727; cv=none; b=NX4ZsSLxfiqJ1ih6R9ma7Lr63v+zquy61RRWmq+hLrFnzan1foYiCOe+K6Zj+rc8ewPXxnojVs7DZhxteQizV1RYpzOpKjPHbqtCaAzE8XdnblaA5yfKpR6wBYwnpQrCdm+FG4cR/sPKOAhP9AJwsH0NbuvXzHXZMXPF89+dYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755646727; c=relaxed/simple;
	bh=aPnEXEI8TH0CQRjYSff/UVlM1XXewUGIM4xEOi9LAos=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=YWq5FVfzFExZsvy6VB3CFSWP+x5kZ85FC7wgjknBwWstmVqsjWNTGXqY1IzBHqabBtJGYrsGoy8LwwJ8oe46CFhc6AlMZhwThvfM5gF9t6PUP3CKk6JA1xS4/GjVvNTKt7tKPF/wHPfIJkxjZqQH/N/438t7wWWILNqkvmqsPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DvzsoGvp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8iG7PUeS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Aug 2025 23:38:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755646723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aivyC6nV4X1QHy/avFC2CYmaso6VzIAOErqH6w8JsoU=;
	b=DvzsoGvp46r8hvMHlJ2EjbuJUR3trxZGZVWCd6uq0XY48h8PXZleHkFOnmjjlfEaNFMaz2
	o9Wlu4L93RuWao6ONYCwBwrhzxzxJyUW/rYP7CKMTzM9MiN3YhQAOGTZ6NOx58MzUS0Wvc
	5saKGcpzvlWElZ/awyf2tvFnsN1quo/EDY9MZzrVhfE+sumZJHDqntXXsu8OQprUeNjQLU
	ZPIVsaZ6VwL2Avgqhak8SNTzYoVw9KT4D5kxQMoynGn8NgRLV0iYgiWcA90dmOT2OC04PO
	6WJRXy9b8YwDNy0GZW2vrdyQY6DZCXJuKKj1x4Si9j1eFFdjkLr0Jnsn16F50A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755646723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aivyC6nV4X1QHy/avFC2CYmaso6VzIAOErqH6w8JsoU=;
	b=8iG7PUeSwwzRZbznZlfDvQCpfSe3x+IHO3EB3+0e8ZUF5YQLQTu4vciYLSoaAK2kLzCew6
	Mbuse0jRf7Vv2kAw==
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
Message-ID: <175564672078.1420.16983385013215397877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     6a42c31ef324476fb304e137fe71870fcc538c88
Gitweb:        https://git.kernel.org/tip/6a42c31ef324476fb304e137fe71870fcc5=
38c88
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 11 Aug 2025 14:33:45 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 19 Aug 2025 16:06:17 -07:00

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
Link: https://lore.kernel.org/all/20250811213345.7029-1-tony.luck%40intel.com
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
index 9d8247b..e8d1037 100644
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

