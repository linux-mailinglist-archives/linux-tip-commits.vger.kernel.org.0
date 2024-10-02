Return-Path: <linux-tip-commits+bounces-2345-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F1B98E340
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 20:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D302809A1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 18:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6711D1F44;
	Wed,  2 Oct 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQfGrMu6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GuxS3pQa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411C12C54D;
	Wed,  2 Oct 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895507; cv=none; b=BD6JnUIx+ojNI6tXZnYgBkRUOEJGC7rCzPb3mdQhDzRBSYUiZMBgRSFWyPTjnML7JoRb1VVc4/pDVYT6gyoQUqZ4d9kvA3hqkwglTwnAEKUlfR+CA32hYZ9NEA6k1hQ+wTdbYfoONQLaLjhchfLJDqLDIMBR3JzcjXYIHcBo8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895507; c=relaxed/simple;
	bh=TZAc+3HzJWmGSh1Fl0shQs+O5rcwdCdWulgOUjXrp2Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ehe8BbvEAIGBBU7Nk2ZIZNZhYmNdnWWgH5Br9CEA6wKLwzd4+A0R5Mj6LspeKdX+8BzvHsHymCgWu9cZuheEO8+TW8VBkZ/aIcHzNLZuKu2tANU3ZrEzSdLwaSY090eZgshb3XP2PWSuz/8vNLkNrJEUm35Ac3dsY0C5sfuMbMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQfGrMu6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GuxS3pQa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 18:58:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727895504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=doGHny0zUWYimKjxEnL4v6SYgVVZXBlh4eUhNF9Zu/s=;
	b=SQfGrMu6k9TM+ilIM22fAylzwh1nW1duRKx1/gk8FB0OSqXas3gGMzblC564dsELo8QskU
	61cps+qFEbVohIBjVSNv08kOzx73Crty9I2VjkVoKLGQ5PXhcPIm+05qFa26hUesUIzlXp
	gSa2UeZvcVHMH4BqE/bGAmMnGLAlXtjYWjmXd/heh9L88yjerucOW246V+Vyz5FnjVCdDb
	y1UEMzXeqYkq1OcZgcker6aaAeYqjDV/iGfG7cbeMPVXo+tjg2c6n/xKeiZtMHQnXQ789m
	hbTp7jaAfhPLsHjH1oaK8ZOYq9gXRZwSivI6NBHtWYcjAuxDRdnXnuJnUnbisg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727895504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=doGHny0zUWYimKjxEnL4v6SYgVVZXBlh4eUhNF9Zu/s=;
	b=GuxS3pQas5v7/QtCGuXvDN7c5qyw2P9tOzBfF7JO2CjuSmC8KZSKPyJd56UVAPv2w3mzKD
	bP0Ff1fTg2TE34Ag==
From: "tip-bot2 for Xi Ruoyao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Don't disable PCID when INVLPG has been fixed
 by microcode
Cc: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172789550330.1442.15896031369850136913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f24f669d03f884a6ef95cca84317d0f329e93961
Gitweb:        https://git.kernel.org/tip/f24f669d03f884a6ef95cca84317d0f329e93961
Author:        Xi Ruoyao <xry111@xry111.site>
AuthorDate:    Wed, 22 May 2024 10:06:24 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 02 Oct 2024 10:59:07 -07:00

x86/mm: Don't disable PCID when INVLPG has been fixed by microcode

Per the "Processor Specification Update" documentations referred by
the intel-microcode-20240312 release note, this microcode release has
fixed the issue for all affected models.

So don't disable PCID if the microcode is new enough.  The precise
minimum microcode revision fixing the issue was provided by Pawan
Intel.

[ dhansen: comment and changelog tweaks ]

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
Link: https://lore.kernel.org/all/20240522020625.69418-1-xry111%40xry111.site
---
 arch/x86/mm/init.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index eb503f5..101725c 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -263,28 +263,33 @@ static void __init probe_page_size_mask(void)
 }
 
 /*
- * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * INVLPG may not properly flush Global entries on
+ * these CPUs.  New microcode fixes the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,	    0x2e),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,    0x42c),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT, 0x11),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,	    0x118),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,   0x4117),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,   0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;

