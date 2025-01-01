Return-Path: <linux-tip-commits+bounces-3161-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021CD9FF3F3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 13:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167F73A27EB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376A41E0E08;
	Wed,  1 Jan 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpASXSGB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nl5phy3q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF021C6F55;
	Wed,  1 Jan 2025 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735733658; cv=none; b=Z0eQvAtjOt9pdV2Kxi0Oykg4AQpjnZRsp0q5MntHLzOU6QCBaMJ+pDSfiB8qiDE6A9TWpVQnavGaTqglDM0fTvbI+xMF6nV+ksz49qAV00uGRKPDC0jv1eN2Mw4lU2p3JwENZSPtPDb37W0eZOmTbXAf2k1oXA33jGksL3lQEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735733658; c=relaxed/simple;
	bh=o+C8VbmEqOAE8fgSMcssEgxRtu7cdruuG9q3taSx3KE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=K+VA22ox3bJeekpLwvHr8J9jDIEuzVohw1vK5CgFrLUHgt54TneoupYd6iMYBGxxncLB5y89TrvpGAErixxu7o/8osdR0jHMPD7cqi6mr8zu7/xjMB4gPwHNpLLzmJJ+E7PmB/LPBi9Uz23cIbcdwo+xXzYWVlhNc3v+21zavsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qpASXSGB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nl5phy3q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 12:14:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735733654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1rm5piiWBUSLbXdLqqdXSFyHSfv+ahl09oO3b66qrXY=;
	b=qpASXSGBU6Wb6lf+bnnHZh+BBYNlrDYTO+ifc5rRvHF2fPP+t+unr8npPpZ+OenukXBaIb
	KJygIGvph/9cTrOTurHHeb3TYqgbL7PZgtxHSOqOpsrzPSzc91ch+UHDYI6KXOZpJQ8iJA
	7KUR3rjtqDrjHMMld1r1Hdk0KFtJe48wZuqUcThdvHxdHhKoAeO1Rz4Hi4qPiThky4Vrkg
	5r6LFczdwPqKfrNZzb59FjvTdrvB+pkQXCz9GG1oc9myp5YVakVkvmSqfFcLN86MSukhUR
	nJh7EGHXo27/mah9MOj/1YF1qfNvf45tayWSnBZmzMjIN8xapolW0Z9pGq8Fsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735733654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1rm5piiWBUSLbXdLqqdXSFyHSfv+ahl09oO3b66qrXY=;
	b=nl5phy3qPgwI+7DrhkkCeFsnVazhcHBvNy5FcXgku0hrJryt2u1DOP7aUnDlBsEpviG7TT
	pBh9ljfQQ2VGsSBw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Remove ret local var in
 early_apply_microcode()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573365385.399.17486275051570088206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     ead0db14c7266c34b1f8a6db6e15e2f4100a9e9e
Gitweb:        https://git.kernel.org/tip/ead0db14c7266c34b1f8a6db6e15e2f4100a9e9e
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 31 Dec 2024 13:58:56 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 14:03:41 +01:00

x86/microcode/AMD: Remove ret local var in early_apply_microcode()

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index ac3fd07..a5dac7f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -528,13 +528,12 @@ static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
 {
 	struct cont_desc desc = { 0 };
 	struct microcode_amd *mc;
-	bool ret = false;
 
 	scan_containers(ucode, size, &desc);
 
 	mc = desc.mc;
 	if (!mc)
-		return ret;
+		return false;
 
 	/*
 	 * Allow application of the same revision to pick up SMT-specific
@@ -542,7 +541,7 @@ static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
 	 * up-to-date.
 	 */
 	if (old_rev > mc->hdr.patch_id)
-		return ret;
+		return false;
 
 	return __apply_microcode_amd(mc, desc.psize);
 }

