Return-Path: <linux-tip-commits+bounces-8132-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDJyKrZoemmB5gEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8132-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:51:18 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F42AA8476
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA824300610C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06846371049;
	Wed, 28 Jan 2026 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jNKmbgCn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1NyuxFd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C62FE575;
	Wed, 28 Jan 2026 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629874; cv=none; b=cHE5/QLtUUGdfLiFZ4wYQJn8LqBVzYq2J3rckxQQpDdaNzijbIWQed85AD3Ft+8I9kPSz43pcT6Ut1RmH2wms6lHV90xyYY4hIqYVv4vQSlELbHRFy0gycmjCtmbo+93Cso+fy2J7qvIznusAPwb7b9RdlIZebGI+AFAtbTdztM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629874; c=relaxed/simple;
	bh=x/GsFp9Gc3qvdpfW1Z3NlU+/IuYBNEV97Sw0uHGVRjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NG/7F8B8WSY4gmZG1VD4hPjSu+O0Eu2wdcQxNbfZYCa7/77LRuH3Z0zZpcDPuuniKt5zV6kFeSaXPBrOQ8wll4MwTkmCQrMnyp0/FTaij6DHZ6TLM41ogCAhfzjn3GYb5awiMO7HyYwRNh1enSxihxFIslk/zUN71leJrVBocxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jNKmbgCn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1NyuxFd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 19:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769629872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBcb6AnMssdq9RPNxbwmu45Tzz+Pw2y3wv0eW0WAKMU=;
	b=jNKmbgCnzMZAfnrRGH0dQAvNEXWyefVwp7ZnF8gnpxoIlzujlRp/fTxkMvtcO6TmreJmUM
	BdHoyJoWACr1FX59Xifmsv9WaNg5Z/yz5tb94X0sceDjkbmxRsuAnp0J2xZiNpiHyPEhX4
	hOa3MH8Lo8ygEcLrCbNnNP5QOmtqvMooc344THaoXV+HNl+Lt1gL6SJsxpeEctFRObyx4G
	IbmqjP1ERR7NMmeUuxD9H/1yWs3rC8aII7NWtIkiFAaGBgLNBDgmEiYOspIIYNMDvRSHPD
	X2ecfuxt0PBFC3SL+VKbgwy3N/CyTIU2+mK4rri18dj1MlHqEephG3Uqwuz4Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769629872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBcb6AnMssdq9RPNxbwmu45Tzz+Pw2y3wv0eW0WAKMU=;
	b=j1NyuxFdnA63rFLLqt5BWbTp0a0i+my3zfzGVR3WpA9XTMCFq8q0t23YZ8QCyMNSBN/ZoU
	veJ/cTdIEeQ1aiCQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] tomoyo: Use scoped init guard
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260119094029.1344361-6-elver@google.com>
References: <20260119094029.1344361-6-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176962987100.2495410.7579653018712943913.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8132-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 7F42AA8476
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     41539433b32d71aea9f7ada84dc6a8bd014ca50d
Gitweb:        https://git.kernel.org/tip/41539433b32d71aea9f7ada84dc6a8bd014=
ca50d
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 19 Jan 2026 10:05:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 20:45:25 +01:00

tomoyo: Use scoped init guard

Convert lock initialization to scoped guarded initialization where
lock-guarded members are initialized in the same scope.

This ensures the context analysis treats the context as active during member
initialization. This is required to avoid errors once implicit context
assertion is removed.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260119094029.1344361-6-elver@google.com
---
 security/tomoyo/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 86ce56c..7e1f825 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2557,7 +2557,7 @@ int tomoyo_open_control(const u8 type, struct file *fil=
e)
=20
 	if (!head)
 		return -ENOMEM;
-	mutex_init(&head->io_sem);
+	guard(mutex_init)(&head->io_sem);
 	head->type =3D type;
 	switch (type) {
 	case TOMOYO_DOMAINPOLICY:

