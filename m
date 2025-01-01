Return-Path: <linux-tip-commits+bounces-3156-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19319FF3DD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813F03A2CC8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653E1E22E9;
	Wed,  1 Jan 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iB67DuH5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsaSTzaX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720DEACE;
	Wed,  1 Jan 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735731858; cv=none; b=g0uligHE4Z0wnLEEkWP5i4Zg4ogav+4On6M1JUisK8qo+FYotvFZFF47RB/zGXDBS3GEqG8ifTGeQewMamHqhkNqzhvNBt13M9hQdkZed1C0X04uvZTZkCCuuyZCh2FnFOPlnhC1wC7Ow2BgMsr59KJdvzDH0fe7IhX1lr4fQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735731858; c=relaxed/simple;
	bh=MEyeHRWV//I4V1eH+9Sd1f8UZ5bKwzG5uQ9amEpS3Hg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HQRzusvF8fSxqonHURm8o3np5kJhrluhw6EWCEZXyGBDPIQ0p9c8Uo0NnIzqG0tV/3wbM99yGKim7KuuaMHizkqhPpCqM6hwA8E39CG8cQg/i9Sh+xSaCvC9sUgRR7qPH+q+4Phw+o5GBDEr7ZF+52qqD6DhGdailcVTbJCN7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iB67DuH5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsaSTzaX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 11:44:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735731847;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2tVPyDzOY6AloWdGyH2gpQB3iVBNrl4WgaVNXkkNBI=;
	b=iB67DuH5ncGyKw2G9+M55VQjDXEz1US4TpV5qpBZHkA2VjUZcb4kB8cPfRlqIYPWPPY14X
	44TOh+SsLD4O1erT4dpTvdFo8XjRjcvCi6fhTGM0OvS4w8J0k+fz2FyGTV+jOB4J2kRzt9
	AZEg8KsXQeRrZ1thvdGlLgMcCMxpWMN/cj6JWtXLT8R3ZIzvEX2/DKmJHG6LXC5BFEmBlZ
	eDfnCe1Fj/p5ORcmqlfqodn3hTMxV/HyCUu8kEUsnXgDCyo+EW2VLjVS6T14x/hRZP7wUe
	MFcVKyKPgu2f/CDGElUgynaX/nkHPc0GizRpsuYWttAKblz3NymVZoGdr5phmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735731847;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2tVPyDzOY6AloWdGyH2gpQB3iVBNrl4WgaVNXkkNBI=;
	b=CsaSTzaXnRMJJjaiz4AJEG0Oa4aiCLOLgIZv+kbzT60cODd/ibh3J9ycmb8bgyyfK1eQs/
	peXMem+aiaO600BQ==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/core] x86/mce/amd: Remove unnecessary NULL pointer initializations
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241212140103.66964-8-qiuxu.zhuo@intel.com>
References: <20241212140103.66964-8-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573184404.399.677738006176037845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     0a6c5391f8812323300057f4dbb89b8bf886ee8e
Gitweb:        https://git.kernel.org/tip/0a6c5391f8812323300057f4dbb89b8bf886ee8e
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Thu, 12 Dec 2024 22:01:03 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 11:14:36 +01:00

x86/mce/amd: Remove unnecessary NULL pointer initializations

Remove unnecessary NULL pointer initializations from variables that
are already initialized before use.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20241212140103.66964-8-qiuxu.zhuo@intel.com
---
 arch/x86/kernel/cpu/mce/amd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 018874b..c79a829 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -921,8 +921,8 @@ static void log_and_reset_block(struct threshold_block *block)
  */
 static void amd_threshold_interrupt(void)
 {
-	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	struct threshold_block *first_block, *block, *tmp;
 	unsigned int bank, cpu = smp_processor_id();
 
 	/*
@@ -1201,8 +1201,7 @@ out_free:
 static int __threshold_add_blocks(struct threshold_bank *b)
 {
 	struct list_head *head = &b->blocks->miscj;
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
+	struct threshold_block *pos, *tmp;
 	int err = 0;
 
 	err = kobject_add(&b->blocks->kobj, b->kobj, b->blocks->kobj.name);
@@ -1312,8 +1311,7 @@ static void deallocate_threshold_blocks(struct threshold_bank *bank)
 
 static void __threshold_remove_blocks(struct threshold_bank *b)
 {
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
+	struct threshold_block *pos, *tmp;
 
 	kobject_put(b->kobj);
 

