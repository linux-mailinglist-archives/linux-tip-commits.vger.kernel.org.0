Return-Path: <linux-tip-commits+bounces-8358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAolDBaPqGmzvgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 20:59:18 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC020755E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 20:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C6B7302E1FD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF443E0C66;
	Wed,  4 Mar 2026 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qltqAVzF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0SJevO9v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B43DFC83;
	Wed,  4 Mar 2026 19:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654348; cv=none; b=Z4DHUnyS8eBvfvxj8cGlPewUOGHGCFQ8gX6NZDYQSOzLQi8sB9odUqyKuWKll060s1aYRq5oaLSL5FEmeLkpDDuvW2jSNXzgrRXoPG8HUDYOUNCTdSMgAIZLJnzBy6oSJLuNVZcuuMfiqQMa6anNAvCKblcHrx6EnIpuMoaADs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654348; c=relaxed/simple;
	bh=Mujw3Bx/aROiBl7sF63TJTyHmMX21OvP/2vwloT0Xhc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FoAomX9ItWDk+mJRJyTSAJFLFSxMjdhRmuIHx8h3j2ckZ8eofJqgeIudRl6d3pqFs+K/XjDsTI93MNDA7x6xQF/LF7LLUMNtLKR3g0dN7X0CFmvaAneJVC1mQD8caF2rOhmVFxpwJxzF6ugu3AlGWVMEKdRsJGDfqiDlozfYN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qltqAVzF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0SJevO9v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 19:59:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772654345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCxITRcosTVTVTaJV8t718AO+Z34ZdfFVcsZu25M1mM=;
	b=qltqAVzFgujIul5u6+wMC68SKTZo0VretNoaFoPhzJSM890878tgXKDgGK/J/BWLlbc6LS
	0fcsL8Vuo8ajrXY7HXvUkUZ8lff46eI5Jd5ajrqjibMQlRbpAMoV4Y6iie+9lioMfD6tFj
	bSzV/qexBB/7u9L9FL4o7OzfIK/uLZO16OmiUwjO4Go3ySzHdMtpwel+M1oJWrIqAbq+rl
	dmAwfvdvfXeA++Coda+VcWXIx1Hh2jMDWdvxMUv9eJd15aGRZ4CIgzP0guAMY6ln0Ce8HS
	+dT1xX29cxnJOJy8IEaEjot2tS5rkWBXlpU8lhQktXufC0abbaGiubHsXqtraw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772654345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCxITRcosTVTVTaJV8t718AO+Z34ZdfFVcsZu25M1mM=;
	b=0SJevO9vAihY7VH9EOYLgGcHVYnsTTwOODiyuXX3DfjypZpXGKVZmtx2JTvPZBswFSYXW/
	nX7p0SfSFph2ZHCg==
From: "tip-bot2 for Vishal Moola (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Convert pmd code to use page table apis
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303194828.1406905-3-vishal.moola@gmail.com>
References: <20260303194828.1406905-3-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177265434435.1647592.1419041465159802414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2EEC020755E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8358-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,intel.com:email,linutronix.de:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6ba1917a4c5c59415c8fc3f83019d92e3f81c87c
Gitweb:        https://git.kernel.org/tip/6ba1917a4c5c59415c8fc3f83019d92e3f8=
1c87c
Author:        Vishal Moola (Oracle) <vishal.moola@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 11:48:25 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 04 Mar 2026 10:08:54 -08:00

x86/mm/pat: Convert pmd code to use page table apis

Use the ptdesc APIs for all page table allocation and free sites to allow
their separate allocation from struct page in the future. Convert the PMD
allocation and free sites to use the generic page table APIs, as they
already use ptdescs.

Pass through init_mm since these are kernel page tables, as
pmd_alloc_one() requires it to identify kernel page tables. Because the
generic implementation does not use the second argument, pass a
placeholder to avoid reimplementing it or risking breakage on other
architectures.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Link: https://patch.msgid.link/20260303194828.1406905-3-vishal.moola@gmail.com
---
 arch/x86/mm/pat/set_memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index a4b1b32..72a2600 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1420,7 +1420,7 @@ static bool try_to_free_pmd_page(pmd_t *pmd)
 		if (!pmd_none(pmd[i]))
 			return false;
=20
-	free_page((unsigned long)pmd);
+	pmd_free(&init_mm, pmd);
 	return true;
 }
=20
@@ -1549,7 +1549,11 @@ static int alloc_pte_page(pmd_t *pmd)
=20
 static int alloc_pmd_page(pud_t *pud)
 {
-	pmd_t *pmd =3D (pmd_t *)get_zeroed_page(GFP_KERNEL);
+	/*
+	 * Pass 0 as a placeholder for the second argument, since the
+	 * generic implementation of pmd_alloc_one() does not use it.
+	 */
+	pmd_t *pmd =3D pmd_alloc_one(&init_mm, 0);
 	if (!pmd)
 		return -1;
=20

