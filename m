Return-Path: <linux-tip-commits+bounces-8183-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAc0AW4RgWnmDwMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8183-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Feb 2026 22:04:46 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528BD1729
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Feb 2026 22:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 090A1300BBA4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Feb 2026 21:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6669B31076D;
	Mon,  2 Feb 2026 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KtWTItII";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mj4ufE9u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB6309EFA;
	Mon,  2 Feb 2026 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066284; cv=none; b=WlNx4FAtiv8gWw9/RhZYZMvX51JakLl7bW2FrLOSWLpBZjs8cWCiuar0ZTlD9IwPQbaj81z4FnUO1z8pCZDgEzjAev9jvxOWu3NWQjJv0MnCKY9LhApYPRrfrxXtFXv797b660b25Uz84CQKiyE2Bzr9hWG8MoaKuOiEsdbluAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066284; c=relaxed/simple;
	bh=QbIAOtRlO2ShlwFLNZ2dEgLXZ/UvIwlv4SWpIVKIJBg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W4Do2mNoswy/MgBzpoLC14iUGPJf8bMM1R7+lUDnMX6/aGKTKW9EvHlxjeDwY9Z6aNiViq6IiScoUSLdKdB/WVSpiXXu1KTcj0VuUxoHNR8m1+IZEz39ApCwg6QaJlj0IOwGntBZIiZl0PY5y1ADGgCfVD18G6ilZrc+izc96mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KtWTItII; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mj4ufE9u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Feb 2026 21:04:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770066281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDYEEOqKAGudKXLZwe1DxIcxwsJXANr5HCHoQSOexWU=;
	b=KtWTItIIMlFTsb2k9fd1XaPqeVwRct9e2LrZ3qFAdH/DceLzU5KrCzcZXveiJEA047NXPb
	wK6W3/GWZbK3bF+CmrQNs+oFcTT3wEW/ainARQYJR9J8j2nFNFQ3zKgq46ys7TROQzfUgN
	wf8Y7qzm0Y3iFflLrZZOBWDwbf83nlX5TI56IYpYxG1hb4CU/cONHxKMnX1wtdKfMsIQ9t
	3VaDJtzb7oCasxeJCJ0KXAaV19K4g4QQOpQ8O8Cej/+PJRm93gIFuSXEq4BaUPdthBlWMg
	knn2QF28EoMsySMPmp20HZlYmOPbTAHxyfjic5PnY9UX/peUYvhY6XaHQdoU4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770066281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDYEEOqKAGudKXLZwe1DxIcxwsJXANr5HCHoQSOexWU=;
	b=mj4ufE9uR42Ibe4FoNyPvS3hc09ETDdLCoviXD8PIRBxpoQ1VCgsOvypS9/kCV8TEeN5Sd
	pDaUTsXJchwQrWAA==
From: "tip-bot2 for Xiang-Bin Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/ibs: Fix typo in dc_l2tlb_miss comment
Cc: "Xiang-Bin Shi" <eric91102091@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260123075719.160734-1-eric91102091@gmail.com>
References: <20260123075719.160734-1-eric91102091@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177006628012.2495410.17536657434142893959.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8183-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:replyto,infradead.org:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 9528BD1729
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     171efc70097a9f5f207461bed03478a1b0a3dfa6
Gitweb:        https://git.kernel.org/tip/171efc70097a9f5f207461bed03478a1b0a=
3dfa6
Author:        Xiang-Bin Shi <eric91102091@gmail.com>
AuthorDate:    Fri, 23 Jan 2026 15:57:19 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Feb 2026 22:01:07 +01:00

x86/ibs: Fix typo in dc_l2tlb_miss comment

The comment for dc_l2tlb_miss incorrectly describes it as a "hit".
This contradicts the field name and the actual bit definition.

Fix the comment to correctly describe it as a "miss".

Signed-off-by: Xiang-Bin Shi <eric91102091@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260123075719.160734-1-eric91102091@gmail.com
---
 arch/x86/include/asm/amd/ibs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index 3ee5903..fcc8a5a 100644
--- a/arch/x86/include/asm/amd/ibs.h
+++ b/arch/x86/include/asm/amd/ibs.h
@@ -110,7 +110,7 @@ union ibs_op_data3 {
 		__u64	ld_op:1,			/* 0: load op */
 			st_op:1,			/* 1: store op */
 			dc_l1tlb_miss:1,		/* 2: data cache L1TLB miss */
-			dc_l2tlb_miss:1,		/* 3: data cache L2TLB hit in 2M page */
+			dc_l2tlb_miss:1,		/* 3: data cache L2TLB miss in 2M page */
 			dc_l1tlb_hit_2m:1,		/* 4: data cache L1TLB hit in 2M page */
 			dc_l1tlb_hit_1g:1,		/* 5: data cache L1TLB hit in 1G page */
 			dc_l2tlb_hit_2m:1,		/* 6: data cache L2TLB hit in 2M page */

