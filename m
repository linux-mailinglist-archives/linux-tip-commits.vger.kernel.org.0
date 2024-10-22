Return-Path: <linux-tip-commits+bounces-2525-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67129AB36A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 18:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D947F1C21F8D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012321B0100;
	Tue, 22 Oct 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xd05gFqZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P8FOqF1n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A119D8A8;
	Tue, 22 Oct 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613314; cv=none; b=hUmWUB+73aZRFxVzdON86mq82bZKk3ukAWclNfEypfWazREtW17fIBS7sqAAo82X46fHBjrv8OoGyEIgq8flQxUisHcelV9mo0PwdcM6r5yaR1oPleCQB1qmDKZfQZ2d4UQA6p49YZtP2RPkNF3x5PFMwBDx8h8Q9Bmck51h0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613314; c=relaxed/simple;
	bh=2J91fMZLfKgNm/BpkIDfhBHSaUmDMGvfLes74qAznuY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rprHAm7/B2Sz1KNIyMqHROmmq1O6d0W6Li9OI3zgGE6oqpgaST8V0uAwg3cpBpQ3SR9I0iKG0ROtPUta/v+5+B4I1x5quDgb9+Ip9frCY4Vj4KTdc7XObQPXTFkDUX0MsQFMDj+jTTi8UQ7nV7GjhhVPZnjl0Pvr0LpL1ZpL9xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xd05gFqZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P8FOqF1n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 16:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729613307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJUgA4eWglJSo0LTUiOTixQ8dmHIM9QC9/ZO0h9BkFw=;
	b=Xd05gFqZVs1eJUjmgevJikgL2QSPxMQ2m+8IgULGpFyeFn3gOnYXF0UbyzU6W8nUqEc266
	drD0b9SDZjAaBSw5yUgtAthQApu/O3aN7GlwwSBMfBGX2ckFv2S/H3mu0/QtWuue8bfikO
	f5E+9VbygvYhwu1+eGoRU/HTXCzWgUiMAlu05XTS7RbXcrP/+9r4gHnrRAxBJbYVEFakGB
	mWHLfQrObvcG/mROeobdi05TeeocflFc5r3tV21Oyt8eDSD2OTwZVdI9MSUW8mF8EHVEDd
	5cJui+xDHypffgTJ+59pfuspPnBCd9h7KaYodONgJORsNa7F7QxEd3zI1nurZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729613307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJUgA4eWglJSo0LTUiOTixQ8dmHIM9QC9/ZO0h9BkFw=;
	b=P8FOqF1n6o7PqSB/WB3/DDjoZ2qVhpECe2mwkiQ8UhEayPTbrDBmppvs78FMUV31zQ1vEw
	BGqceiujSvYWFlAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Pay attention to the stepping
 dynamically
Cc: Jens Axboe <axboe@kernel.dk>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172961330684.1442.17411760938161239553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d1744a4c975b1acbe8b498356d28afbc46c88428
Gitweb:        https://git.kernel.org/tip/d1744a4c975b1acbe8b498356d28afbc46c88428
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 21 Oct 2024 10:27:52 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 22 Oct 2024 16:37:13 +02:00

x86/microcode/AMD: Pay attention to the stepping dynamically

Commit in Fixes changed how a microcode patch is loaded on Zen and newer but
the patch matching needs to happen with different rigidity, depending on what
is being done:

1) When the patch is added to the patches cache, the stepping must be ignored
   because the driver still supports different steppings per system

2) When the patch is matched for loading, then the stepping must be taken into
   account because each CPU needs the patch matching its exact stepping

Take care of that by making the matching smarter.

Fixes: 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/r/91194406-3fdf-4e38-9838-d334af538f74@kernel.dk
---
 arch/x86/kernel/cpu/microcode/amd.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f63b051..1ae36ab 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -613,16 +613,19 @@ static int __init save_microcode_in_initrd(void)
 }
 early_initcall(save_microcode_in_initrd);
 
-static inline bool patch_cpus_equivalent(struct ucode_patch *p, struct ucode_patch *n)
+static inline bool patch_cpus_equivalent(struct ucode_patch *p,
+					 struct ucode_patch *n,
+					 bool ignore_stepping)
 {
 	/* Zen and newer hardcode the f/m/s in the patch ID */
         if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
 		union cpuid_1_eax p_cid = ucode_rev_to_cpuid(p->patch_id);
 		union cpuid_1_eax n_cid = ucode_rev_to_cpuid(n->patch_id);
 
-		/* Zap stepping */
-		p_cid.stepping = 0;
-		n_cid.stepping = 0;
+		if (ignore_stepping) {
+			p_cid.stepping = 0;
+			n_cid.stepping = 0;
+		}
 
 		return p_cid.full == n_cid.full;
 	} else {
@@ -644,13 +647,13 @@ static struct ucode_patch *cache_find_patch(struct ucode_cpu_info *uci, u16 equi
 	WARN_ON_ONCE(!n.patch_id);
 
 	list_for_each_entry(p, &microcode_cache, plist)
-		if (patch_cpus_equivalent(p, &n))
+		if (patch_cpus_equivalent(p, &n, false))
 			return p;
 
 	return NULL;
 }
 
-static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
+static inline int patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 {
 	/* Zen and newer hardcode the f/m/s in the patch ID */
         if (x86_family(bsp_cpuid_1_eax) >= 0x17) {
@@ -659,6 +662,9 @@ static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 		zp.ucode_rev = p->patch_id;
 		zn.ucode_rev = n->patch_id;
 
+		if (zn.stepping != zp.stepping)
+			return -1;
+
 		return zn.rev > zp.rev;
 	} else {
 		return n->patch_id > p->patch_id;
@@ -668,10 +674,14 @@ static inline bool patch_newer(struct ucode_patch *p, struct ucode_patch *n)
 static void update_cache(struct ucode_patch *new_patch)
 {
 	struct ucode_patch *p;
+	int ret;
 
 	list_for_each_entry(p, &microcode_cache, plist) {
-		if (patch_cpus_equivalent(p, new_patch)) {
-			if (!patch_newer(p, new_patch)) {
+		if (patch_cpus_equivalent(p, new_patch, true)) {
+			ret = patch_newer(p, new_patch);
+			if (ret < 0)
+				continue;
+			else if (!ret) {
 				/* we already have the latest patch */
 				kfree(new_patch->data);
 				kfree(new_patch);

