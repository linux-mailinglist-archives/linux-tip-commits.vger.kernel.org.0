Return-Path: <linux-tip-commits+bounces-3341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB0A29DF9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Feb 2025 01:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6BF57A2E0F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Feb 2025 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D28F4ED;
	Thu,  6 Feb 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OSV4l1mt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/KJZS2aU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E70B672;
	Thu,  6 Feb 2025 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802369; cv=none; b=DHC58P3PQ9ycObUc8GuQSQoU3AesfSgFQmLoFamOwO13UFndAFvQ+hXxaTKyAx09siAQGyAsKwIJTWo4tvlj2ggl5lE1u/oExCNxQPfrwmRDc5eh9mnqhlzN9c6qQTjl78uytvn8cjZfvs9OfZ+7mulP5bkzkAsu7M7a0+QdwPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802369; c=relaxed/simple;
	bh=dSSyBXccQbzzqU9ow0bKyliJTGRZAtxTLvrCXZNNAa4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sxS1EBCbPSCwWWIOqjDucTkNhxFkdTVm92JoY5vscYe7ac5/SnOl/j1SBsaNRGYhqD33sxRdBre+V7EoOVyTyognWsiyD7xqYiyk5v3BFAs13KTk2wa2sJlehwMmv6m5xjh+oOcM3Fhauj42Zd5+5i/AUGW6nplVcbOfQKcNj3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OSV4l1mt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/KJZS2aU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Feb 2025 00:39:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738802365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Byo077Hg3W7wtTTe8y9nW+rnNGEnTJlmN8DzLq/ojxc=;
	b=OSV4l1mtVueamIDPP76s4CfnkVPk8VytGZ7vQDMxd8gzpFy+uOlHber8LelQ+/SSNS4o9d
	XNUB1IDSq68BbUx/EYhzVG5Tbw81J6YEJ2sT0IBCRYvojp3AYMqJx1KFkFRK8bvpxu+WQp
	VE3JiQYllyTmhQ003YoocFz1EUVPhwJmcmT3Ql4EQEr/T1PWYssCzfLmF7nNYqRKlyFOPT
	8jRtxrNArpaQVl3efgYLeTZd58uY3G3r8bsacvs7YmvsiPMoh/0xvgeSAgYSMk8EKhNpdn
	qwINnk58MwXcIX0PvNQoLytvUkDQjdHEbHWFNUG6emF/rxbGReoLzdZIzt7e8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738802365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Byo077Hg3W7wtTTe8y9nW+rnNGEnTJlmN8DzLq/ojxc=;
	b=/KJZS2aUH5tgKCFgxSmUCjABH32IRpYz6u/yR/vfSNHucKI9KDs9uIqEL5Uwbyq+oyTJQQ
	eu3oTX18CiVUNMAA==
From: "tip-bot2 for Maciej Wieczor-Retman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86: Compare physical instead of virtual PGD addresses
Cc: "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173880236261.10177.14147520520179813519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     63887c9f02030afd042c125052ad60680f7c21b2
Gitweb:        https://git.kernel.org/tip/63887c9f02030afd042c125052ad60680f7c21b2
Author:        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
AuthorDate:    Tue, 04 Feb 2025 18:33:50 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 05 Feb 2025 16:23:17 -08:00

x86: Compare physical instead of virtual PGD addresses

This is a preparatory patch for when pointers have tags in their
upper address bits. But it's a harmless change on its own.

The mm->pgd virtual address may be tagged because it came out of
the allocator at some point. The __va(read_cr3_pa()) address will
never be tagged (the tag bits are all 1's). A direct pointer value
comparison would fail if one is tagged and the other is not.

To fix this, just compare the physical addresses which are never
affected by tagging.

[ dhansen: subject and changelog munging ]

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/fde443d0e67f76a51e7ab4e96647705840f53ddb.1738686764.git.maciej.wieczor-retman%40intel.com
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6cf881a..ffc25b3 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1325,7 +1325,7 @@ bool nmi_uaccess_okay(void)
 	if (loaded_mm != current_mm)
 		return false;
 
-	VM_WARN_ON_ONCE(current_mm->pgd != __va(read_cr3_pa()));
+	VM_WARN_ON_ONCE(__pa(current_mm->pgd) != read_cr3_pa());
 
 	return true;
 }

