Return-Path: <linux-tip-commits+bounces-8357-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGPbJhCPqGmzvgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8357-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 20:59:12 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4434207549
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 20:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA214302A7FC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 19:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7843DFC89;
	Wed,  4 Mar 2026 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhLxwjWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Owj9aU3z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37413D567A;
	Wed,  4 Mar 2026 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772654347; cv=none; b=T3VKY/ArGpdHEC6gKowOTR2ezLbEmmJ4pXlk25O4ngIz8GlyITPsfG+yrqN3yrXU+g/ImnsjGHN2JjcssU08+ravyXRV271zxuu8hecKwUpZoEM2YI3v/ePr3a9iMIEshmH8pl0/OWGiP/v1hZVZ/ONYl+vA4ovrGuP3eujRCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772654347; c=relaxed/simple;
	bh=yu9S46LdnzMMstPRY8h2+nfjfi4r91HfD1/DDwxq76o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IkjMnGIyMdGiWTsz0ELWnbU8xZpwqBr7Z087FBjLOGpQ7Pv5xalbOWof3pQD47CAj0pQwMxGXD7ufwiCyegSraVeIJJeKXALUJII14vQCeXapD+YVAqlgFkV3FR/kf+ZIUW5gSuyiNT0A5WK/wb3Fbxey39y5sq6rwFUnF+u2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhLxwjWd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Owj9aU3z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 19:59:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772654344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47rE7sbafQtfT476qeGsNlRq4P7zFc7sxjDPSvn27Pc=;
	b=AhLxwjWdtoNbG8ypIvI7wE/+b7tl6Lm+qtVgppsYN3x9Aowy3MmwPxjDDDnS3fpM52gSHj
	sV8yrLEBiMqtQ2xsKGKY3J5E5zR6QhOvvNFHQC3lZ0psCUiZc/7dJwwxqrgvEGSc7AD45V
	UTo/QNwNSAmH6G8u+xnJnF9Mn5WaBrkh10aJDp1mpR97FaZfyoRV7Ms5FVuK7d5p+hSJJS
	PUr0+NvcOGEsHBh0yZmVP+NJW3AwZZTWauZfDDgBLQPRLhILNxYv/jnoa+c/uTs8gVRBtY
	+fJXUIHhBehgo366YWpyrbF0ZMwEhBSz50+fZC8XLmPpRMXyOXYwSmnNEFaJpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772654344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47rE7sbafQtfT476qeGsNlRq4P7zFc7sxjDPSvn27Pc=;
	b=Owj9aU3zmYrzolHMMcWe8kEYmRkwdg/pW8OcVrYqx7VizKQ0iQhwA5pYBDbYDjeRgBv9oC
	ex9ZEGOfxjCiwYBQ==
From: "tip-bot2 for Vishal Moola (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm/pat: Convert populate_pgd() to use page table apis
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303194828.1406905-4-vishal.moola@gmail.com>
References: <20260303194828.1406905-4-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177265434322.1647592.2472511505969712816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D4434207549
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
	TAGGED_FROM(0.00)[bounces-8357-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b2203a9bf53237368a7c7fc976c9616b5562af8e
Gitweb:        https://git.kernel.org/tip/b2203a9bf53237368a7c7fc976c9616b556=
2af8e
Author:        Vishal Moola (Oracle) <vishal.moola@gmail.com>
AuthorDate:    Tue, 03 Mar 2026 11:48:26 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 04 Mar 2026 10:08:54 -08:00

x86/mm/pat: Convert populate_pgd() to use page table apis

Use the ptdesc APIs for all page table allocation and free sites to allow
their separate allocation from struct page in the future. Convert the
remaining get_zeroed_page() calls to the generic page table APIs, as they
already use ptdescs.

Pass through init_mm since these are kernel page tables, as
both functions require it to identify kernel page tables. Because the
generic implementations do not use the second argument, pass a
placeholder to avoid reimplementing them or risking breakage on other
architectures.

It is not obvious whether these pages are freed. Regardless, convert the
remaining free paths as needed, noting that the only other possible free
paths have already been converted and that a frozen page table test
kernel has not reported any issues.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Link: https://patch.msgid.link/20260303194828.1406905-4-vishal.moola@gmail.com
---
 arch/x86/mm/pat/set_memory.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 72a2600..17c1c28 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1747,7 +1747,11 @@ static int populate_pgd(struct cpa_data *cpa, unsigned=
 long addr)
 	pgd_entry =3D cpa->pgd + pgd_index(addr);
=20
 	if (pgd_none(*pgd_entry)) {
-		p4d =3D (p4d_t *)get_zeroed_page(GFP_KERNEL);
+		/*
+		 * Pass 0 as a placeholder for the second argument, since the
+		 * generic implementation of p4d_alloc_one() does not use it.
+		 */
+		p4d =3D p4d_alloc_one(&init_mm, 0);
 		if (!p4d)
 			return -1;
=20
@@ -1759,7 +1763,11 @@ static int populate_pgd(struct cpa_data *cpa, unsigned=
 long addr)
 	 */
 	p4d =3D p4d_offset(pgd_entry, addr);
 	if (p4d_none(*p4d)) {
-		pud =3D (pud_t *)get_zeroed_page(GFP_KERNEL);
+		/*
+		 * Pass 0 as a placeholder for the second argument, since the
+		 * generic implementation of pud_alloc_one() does not use it.
+		 */
+		pud =3D pud_alloc_one(&init_mm, 0);
 		if (!pud)
 			return -1;
=20

