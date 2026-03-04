Return-Path: <linux-tip-commits+bounces-8359-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHEFNHaPqGmzvgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8359-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 21:00:54 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CEB2075BD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B28C030D4FA7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F53DFC8B;
	Wed,  4 Mar 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nb+d6Imj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OlrR8FHn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3623E0C55;
	Wed,  4 Mar 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654349; cv=none; b=E81NHpKjACjPs398F041u0vQdbPhcwdLNJfY9Ub/yovSfayzSTHXn7/40z/3zFM6INc0416y/HPoY9oq7sGkkAiemeAr9QqzeB3LWs0I1F2fiOZGVZD1cm3XIPZB/pvcYnQro39mk43uQjsEimH6ouY9ue55UDTslcNz+5y7tzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654349; c=relaxed/simple;
	bh=ZD4WhLeWj9/UhNXpLGTwk7FIJhb6PaWPksxbyJpD0oQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J0+tGDpjoRxCyHw92JM/Cx7ZA21Nxzuy/U8AO+IrvRxHorcrNuLl9Gcfq26yJzqnJaX7zwCLAGybwGn205DYVuLsCrWoJnMzGxDKoZX/Cj4Lnc0xfjHV/jif3C1I/UxAQySWGR7jyq09oTQEWWN2rBOze2OCtd0Z8AkyTLax7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nb+d6Imj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OlrR8FHn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 19:59:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772654346;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3vuh0eC3AwwCTrahJzri/RvjA4yCinww2FxKCg1XO8=;
	b=nb+d6ImjilYaRGyS/LD7N/K4UOe9YK6/ZFC086Ok5tkDhseOaoSBXPi/qFJLygKUP8TkaO
	BAvYQQajERUibKA5sRLocMiRxop27Mzdtvd+Ljfr4MiJUVYfLOWHJFVwMmmspqfjxt0znu
	0zMu6r10WwW+f4ZiM/25jBMzzr413irJf+GxtkICmcpUVbRTMr5bF/4LLtdRFlAnbMzoku
	7iQ9m8aVtZUBGsepkSav0Rq6pSCQH/hI+pW2pNwrcd2m2V1fVKIDVWQ7uL3YvTSf0xKiJM
	yxq62lBBJZvRvcq4u7/XVL8XCQM6RLS3D6W3LyUluVVz5U95TdPAK1dsZD3UxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772654346;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3vuh0eC3AwwCTrahJzri/RvjA4yCinww2FxKCg1XO8=;
	b=OlrR8FHnuRn7talynteU8A9+SrVU8SpxNWEYzLlj34e4QWAdARyBaLvDT94C2V2/DDLRjq
	8xyZ5gfx9YQ2/tCw==
From: "tip-bot2 for Vishal Moola (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Convert pte code to use page table apis
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303194828.1406905-2-vishal.moola@gmail.com>
References: <20260303194828.1406905-2-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177265434552.1647592.7116984595616180374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 40CEB2075BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8359-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,vger.kernel.org:replyto,intel.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c22ca4a96300c8ed01fe2282d2dd9e9a75032379
Gitweb:        https://git.kernel.org/tip/c22ca4a96300c8ed01fe2282d2dd9e9a750=
32379
Author:        Vishal Moola (Oracle) <vishal.moola@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 11:48:24 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 04 Mar 2026 10:08:54 -08:00

x86/mm/pat: Convert pte code to use page table apis

Use the ptdesc APIs for all page table allocation and free sites to allow
their separate allocation from struct page in the future. Convert the PTE
allocation and free sites to use the generic page table APIs, as they
already use ptdescs.

Pass through init_mm since these are kernel page tables; otherwise,
pte_alloc_one_kernel() becomes a no-op.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Link: https://patch.msgid.link/20260303194828.1406905-2-vishal.moola@gmail.com
---
 arch/x86/mm/pat/set_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 40581a7..a4b1b32 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1408,7 +1408,7 @@ static bool try_to_free_pte_page(pte_t *pte)
 		if (!pte_none(pte[i]))
 			return false;
=20
-	free_page((unsigned long)pte);
+	pte_free_kernel(&init_mm, pte);
 	return true;
 }
=20
@@ -1539,7 +1539,7 @@ static void unmap_pud_range(p4d_t *p4d, unsigned long s=
tart, unsigned long end)
=20
 static int alloc_pte_page(pmd_t *pmd)
 {
-	pte_t *pte =3D (pte_t *)get_zeroed_page(GFP_KERNEL);
+	pte_t *pte =3D pte_alloc_one_kernel(&init_mm);
 	if (!pte)
 		return -1;
=20

