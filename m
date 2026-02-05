Return-Path: <linux-tip-commits+bounces-8206-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHe6A4JZhGl92gMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8206-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 09:49:06 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA46F004C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 09:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC0D0300B120
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Feb 2026 08:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4B316193;
	Thu,  5 Feb 2026 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCMX3zF6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JvYCREjE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B102FBDF5;
	Thu,  5 Feb 2026 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281324; cv=none; b=Y92gIKIgRV2cc+gUYUbGWHFY/MTsqwjZ/1lCkUgIbs5eOxP3NjBPE8d9l4AksASip9uK9g1FeGAMNxZgMqrB7KiUd3cRWtho54WfmRYP4phCdbEJIhNbmn8AxfvM0H8uVQJ5fTDccBB0F2vOZQLb0vuRCsdbTXOE9KSuzSorCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281324; c=relaxed/simple;
	bh=cea78TvAanNyX6roORfnlOLBR1A+XLrqhTpfO5GTd3o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a310cWdIqyzkUGZmlbKqIg4cmK7SZ1GQf+JzW2Jy9BhnlsNsiYfMHgYXcjRs+zljKf9IZsLC+YsnSC+M2M/5oCIZX7L6ReQshES9QLcL4a895XaKBr9/SIJkM5IhmoGUQqvnveui47IegKtTu18IwKn7HGqx50x15bBI5yhe0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCMX3zF6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JvYCREjE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Feb 2026 08:48:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770281322;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAajtn/cj1MJ3whaAD3FnVvazR/CIQ1Shd+CwFcdMyA=;
	b=xCMX3zF6E6+1O9KWE3BgxOlMx7vNBuZDMGoQb40R3R87uFbYaFKRKV1o59uoiLMfQHVMkP
	aGV6xezlgd0Ur8l783kKVOzDMDeykxy/6vo5WN0V9fPnRwByV9TOR4nOrZJUKENMPOqx8+
	GHicl1laW82bQgT28eB7EdO1Mjw5gD1HrQ3gZKACf/IO0EaQ8w4nF22FDJu89q6O6KrWOC
	/cKYPph26DZSss/rPjqdbhkisqq//+WEGd02+ywcHSxBQJzxoUb9VijJc+TvBpIz6Z2+yD
	GMfViFVJfo5GC+EYAr8fkefnuyMSBMDh4J3Rrm7fdDmx2zYt2/cPgMYiJ2wUVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770281322;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAajtn/cj1MJ3whaAD3FnVvazR/CIQ1Shd+CwFcdMyA=;
	b=JvYCREjEU7L2+sCNoU+YElWITEskL2IqqU078HzqB/EpeWOPjXNg4Cydh130pbbe8Xn7NP
	4Ay8OtZ68SzeEoCQ==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] s390: remove kvm_types.h from Kbuild
Cc: Randy Dunlap <rdunlap@infradead.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260203184204.1329414-1-rdunlap@infradead.org>
References: <20260203184204.1329414-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177028132153.2495410.5372103271735872748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8206-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 6CA46F004C
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7db06e329af30dcb170a6782c1714217ad65033d
Gitweb:        https://git.kernel.org/tip/7db06e329af30dcb170a6782c1714217ad6=
5033d
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 03 Feb 2026 10:42:04 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Feb 2026 09:43:47 +01:00

s390: remove kvm_types.h from Kbuild

kvm_types.h is mandatory in include/asm-generic/Kbuild so having it
in another Kbuild file causes a warning. Remove it from the arch/
Kbuild file to fix the warning.

../scripts/Makefile.asm-headers:39: redundant generic-y found in ../arch/s390=
/include/asm/Kbuild: kvm_types.h

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260203184204.1329414-1-rdunlap@infradead.org
---
 arch/s390/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 297bf71..80bad7d 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -5,6 +5,5 @@ generated-y +=3D syscall_table.h
 generated-y +=3D unistd_nr.h
=20
 generic-y +=3D asm-offsets.h
-generic-y +=3D kvm_types.h
 generic-y +=3D mcs_spinlock.h
 generic-y +=3D mmzone.h

