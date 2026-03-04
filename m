Return-Path: <linux-tip-commits+bounces-8356-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEkBMQ+PqGmzvgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8356-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 20:59:11 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0178207547
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 20:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E769E3028D75
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4413DFC69;
	Wed,  4 Mar 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqPyr+6c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lgruJtZa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117153D75B6;
	Wed,  4 Mar 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654346; cv=none; b=LOpiJuY/9Dh8IzNGXAUNvFLylYy4shA78hjW7ZzhQnW2fC5n10yIOtaOTeeLwXtUM7Xpp7tlgTVbEwXG2Kl+p3HgvZ2wdrAIiUkzs+52Pm0BXJObrtmxBoWl2sGmLaiWMuIH8RB/pODT5morgVlb0wTcQbmlOB/vv9D6v4BQGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654346; c=relaxed/simple;
	bh=+7e2+ulEyTsk0R5pYpiv/Y8G2wG5FyPhMeqpbMQMOxc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QrnZBFQYbr2waiQnCQJEHBQ1cj2vOQtkj3163/DiLuVtJ3ZnoC46j6LkRzlUmpj32dCPN6HQundnr7uRo4/RDGMnX15bBGhC3vMvxaT13dV71CtmATKsssbZ/XZrfQB7JlkTY38/VgNdiEiyMtU6yfX38tYrAonh3oZl+KLXM7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqPyr+6c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lgruJtZa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 19:59:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772654343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PMEx5UW2X5o/XdNgqS/tkXuOvTpd5E0WF2LHHy/2Jo=;
	b=xqPyr+6cnxoAQyr90kFKjoboqYTrG/1bfYMgi2UZw0oiVc3lzyWCrOAV2K9357FKClYD9Z
	a/KzYPTOOsAE4dictYQD1625xJ0qn8uLGJs5KZslnBJje0tBL98oYEr2nDvG+oHzqcPcj1
	Ysre4636QXRzl3+21o2DQTNZ3GVxQcYogwCQ7QeFUiaJuxrJC59CudsKxVdhnR7nxqzHdp
	y/ebWVISOkN4xehngJrHrvrv/Jy8Ay6AUbg9hoVeplW6zwyFLzzrK6ZaqMqBvlqMLYqh1F
	/vnX9+ZX2Xy6r3KwN5BhMBDyBweCDVEuU6oRexWpc7u4ypLQBjqjpc5D8txnyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772654343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PMEx5UW2X5o/XdNgqS/tkXuOvTpd5E0WF2LHHy/2Jo=;
	b=lgruJtZatUz1RYNdRbpoptMu5OwxHZlQrOQhROpa+57ujgGlHkF6Ua7sjZp1qQIJECMCSD
	ItA1ARpy6pjMoMCA==
From: "tip-bot2 for Vishal Moola (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Convert split_large_page() to use ptdescs
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303194828.1406905-5-vishal.moola@gmail.com>
References: <20260303194828.1406905-5-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177265434203.1647592.15648754014140184815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D0178207547
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8356-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,msgid.link:url,linutronix.de:dkim];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     e751303e0ad2e998f421d104193f6904df3516d1
Gitweb:        https://git.kernel.org/tip/e751303e0ad2e998f421d104193f6904df3=
516d1
Author:        Vishal Moola (Oracle) <vishal.moola@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 11:48:27 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 04 Mar 2026 10:08:54 -08:00

x86/mm/pat: Convert split_large_page() to use ptdescs

Use the ptdesc APIs for all page table allocation and free sites to
allow their separate allocation from struct page in the future.

Update split_large_page() to allocate a ptdesc instead of allocating a
page for use as a page table.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Link: https://patch.msgid.link/20260303194828.1406905-5-vishal.moola@gmail.com
---
 arch/x86/mm/pat/set_memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 17c1c28..cba907c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1119,9 +1119,10 @@ set:
=20
 static int
 __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
-		   struct page *base)
+		   struct ptdesc *ptdesc)
 {
 	unsigned long lpaddr, lpinc, ref_pfn, pfn, pfninc =3D 1;
+	struct page *base =3D ptdesc_page(ptdesc);
 	pte_t *pbase =3D (pte_t *)page_address(base);
 	unsigned int i, level;
 	pgprot_t ref_prot;
@@ -1226,18 +1227,18 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte,=
 unsigned long address,
 static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
 			    unsigned long address)
 {
-	struct page *base;
+	struct ptdesc *ptdesc;
=20
 	if (!debug_pagealloc_enabled())
 		spin_unlock(&cpa_lock);
-	base =3D alloc_pages(GFP_KERNEL, 0);
+	ptdesc =3D pagetable_alloc(GFP_KERNEL, 0);
 	if (!debug_pagealloc_enabled())
 		spin_lock(&cpa_lock);
-	if (!base)
+	if (!ptdesc)
 		return -ENOMEM;
=20
-	if (__split_large_page(cpa, kpte, address, base))
-		__free_page(base);
+	if (__split_large_page(cpa, kpte, address, ptdesc))
+		pagetable_free(ptdesc);
=20
 	return 0;
 }

