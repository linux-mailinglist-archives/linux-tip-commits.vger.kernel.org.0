Return-Path: <linux-tip-commits+bounces-8091-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FlxGeX5cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8091-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:20:21 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C316525B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387C34FF01F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040023C8A0;
	Thu, 22 Jan 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUtKVTYq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHZXlqdi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A869330645;
	Thu, 22 Jan 2026 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076938; cv=none; b=tHMjrcNE9OLf3L9crNcWiTaA4qAmBXBfWW3EezORAgToGs1DocAOrzvhkluyGXAA8CSpRRSPYqMoSWb4EIWF52LvJAyJqAzwOIANwQNiNxEctEZ/GPXvEbV+BPV2fPCwpPxFrs103U2yhuytHK+GlH3Uc6b76LjjX2LL7586khE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076938; c=relaxed/simple;
	bh=RJkThgy8OvMX4q9vybSwZXfGEPksAu6e3vRI4ckE0Xc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ICCEETXzR1Qzi1xOF7J7tK77U39ZnQ+OuoWLqYBTTkofqI7+ISTpeOf/x5cCU2eaBvFXEEiA/z0eeo1oih38/k2ARkUtnAEfR+BVicYOeMlO4jp9qMCOrTTL4lxBCAnoPkFNarpWXAKfGDm2mbTquXAKrO6S28+MuEAIBTmRgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUtKVTYq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHZXlqdi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KNSFC3gP3l+0GhlW5qbxntc8kvtRTGGtgO3BMu4lDo=;
	b=OUtKVTYqO2w6lefJH6I65dXgnYs4fO6bJlzzXaZ6sRidakKC2KnHw3vA3CxTTsBKnV0+zX
	VnDHvbnsWyCmhb4vNc3hnECB+KUky8YMf4DzVBd5ASksCHBrnUsbwJEKs9T1ag5ttws6nr
	n5/JG4tBnHgGgjPXarh5ONQoPyHomBDjAddP0awpMvQ8zF3fJDkdgTNn2brbMIbQ2JssCH
	uKgsnelevClsqRHjYZNYj8z1NItiVOsUXAm9dRi6t3OX8scK/iqxJtz4fTenRmWFCOnNr0
	+VW467ykoL9qSNQu29zopSa5q2nU63kKHiPC87C0jyq7sGB/cBbGsV05T0mdLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KNSFC3gP3l+0GhlW5qbxntc8kvtRTGGtgO3BMu4lDo=;
	b=AHZXlqdipTpPVVkOVYbxLPcY3dLZM5erZe1OJMXoz6U6UpWOx1ZTqdTXfWN8eDsf5DXKf5
	jtQNixvxbHqvfVCw==
From: "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: remove task_struct->faults_disabled_mapping
Cc: Christoph Hellwig <hch@lst.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260122085223.487092-1-hch@lst.de>
References: <20260122085223.487092-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907692904.510.7738554528615146662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,vger.kernel.org:replyto,msgid.link:url,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linutronix.de:dkim,infradead.org:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8091-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: C9C316525B
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     377521af0341083bc9d196cf021ec7265dc47c20
Gitweb:        https://git.kernel.org/tip/377521af0341083bc9d196cf021ec7265dc=
47c20
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Thu, 22 Jan 2026 09:52:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:21 +01:00

sched: remove task_struct->faults_disabled_mapping

This reverts commit 2b69987be575 ("sched: Add
task_struct->faults_disabled_mapping"), which added this field without
review or maintainer signoff.  With bcachefs removed from the
tree it is also unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260122085223.487092-1-hch@lst.de
---
 include/linux/sched.h | 1 -
 init/init_task.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bf96a7d..71654e3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -955,7 +955,6 @@ struct task_struct {
=20
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
-	struct address_space		*faults_disabled_mapping;
=20
 	int				exit_state;
 	int				exit_code;
diff --git a/init/init_task.c b/init/init_task.c
index 49b13d7..7d9094a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -113,7 +113,6 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) =
=3D {
 	.nr_cpus_allowed=3D NR_CPUS,
 	.mm		=3D NULL,
 	.active_mm	=3D &init_mm,
-	.faults_disabled_mapping =3D NULL,
 	.restart_block	=3D {
 		.fn =3D do_no_restart_syscall,
 	},

