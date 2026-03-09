Return-Path: <linux-tip-commits+bounces-8400-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKqKFD0lr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8400-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:53:33 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE8A240650
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01A8B3081B1C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA471426ED3;
	Mon,  9 Mar 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOzx8YlN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OasGHRLu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B81426EA0;
	Mon,  9 Mar 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085718; cv=none; b=Cb6uG9obaaHL28ETCp2J/OjxTrqU4MnFvHOHnbCQLSV0KqBl+yWwXFtIKgl7gE4EHPal9QCcaHPkbYEWUA+aTvQIsotbOIQrEcsxr/FfH2Xzp9f2UMVzXkCLyJR0qwmhIygzc9f2lXvaDmZ2IgfD8uw5cSQ13dOo1iPwcwPTYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085718; c=relaxed/simple;
	bh=Djj6TAVYOggOBrIo5MX+aS+/mhEEDAJXI5yG5bp7XQs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KbOd2+OiRG3fsjktS+tWZ2/6haw+pMaQvLGoo7ZGGYnGL+kOU0QbuPcwYVkCCBJdYRPxAE3+Bgl2eMRzWyJXRshzJvfYBOPJnaetjKOqsBWVZC3JsYyR5WiauLLppTlFFyrMmVMGj3OOTsoKORafcaB0GQMv0SMPSbmF7LMxZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rOzx8YlN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OasGHRLu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bum5H3gGXLOI7P2OxnlBLBDMdWMLhNG49XxnO5fRJfU=;
	b=rOzx8YlN8ooS6Kh7h9s42/pPxZHv8moVJbfzdt0h7NSimmwAkmiYiGHFduYlFkb76h+s8L
	X1KS5t+ZfWK5Nt71saatK0kni7zmQtoAQuzSQw5Qwei+X1Sk/TBcfVxLTIhjQNHGvvbF/n
	bztNHBR0nRQtVnCMc/95kFZqXmXyvXpvc+Oodl3XqsE6t91Hq4cDZi4xViSCZZE6I5Xq3Y
	5tZgBUIIbehMytgnO3t0wzSCy0jkhr7upvY58mKnjiEeqih/idenUEiqvMMo81I294DKsZ
	K0hnWSkZua16dbW0brLcq9Pvrp52FWVC8K5yn941tkp/a3FKHCRNkvKKDRmyJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085716;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bum5H3gGXLOI7P2OxnlBLBDMdWMLhNG49XxnO5fRJfU=;
	b=OasGHRLuCj8t9wqXof8e/1U9dmqMF5he6OTEo6UKGGDDG21l9hCcNSjzVuF00o7NPYbba7
	Lg/AJLJfUkh7/pCg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: add missing function parameter comments
Cc: Randy Dunlap <rdunlap@infradead.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260304005008.409858-1-rdunlap@infradead.org>
References: <20260304005008.409858-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308571488.1647592.2937317232791891169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BFE8A240650
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8400-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:replyto,linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0da9ca4c08e709144a1bd2f765c14205960ac64d
Gitweb:        https://git.kernel.org/tip/0da9ca4c08e709144a1bd2f765c14205960=
ac64d
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 03 Mar 2026 16:50:03 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:47 +01:00

futex: add missing function parameter comments

Correct or add the missing function parameter kernel-doc comments
to avoid warnings:

Warning: include/asm-generic/futex.h:38 function parameter 'op' not
 described in 'futex_atomic_op_inuser_local'
Warning: include/asm-generic/futex.h:38 function parameter 'oparg' not
 described in 'futex_atomic_op_inuser_local'
Warning: include/asm-generic/futex.h:38 function parameter 'oval' not
 described in 'futex_atomic_op_inuser_local'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260304005008.409858-1-rdunlap@infradead.org
---
 include/asm-generic/futex.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 2a19215..fbbcfd8 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -25,7 +25,9 @@
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
- * @encoded_op:	encoded operation to execute
+ * @op:		operation to execute
+ * @oparg:	argument of the operation
+ * @oval:	previous value at @uaddr on successful return
  * @uaddr:	pointer to user space address
  *
  * Return:

