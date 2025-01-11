Return-Path: <linux-tip-commits+bounces-3200-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013A2A0A3D6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Jan 2025 14:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68CB188B8CE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 11 Jan 2025 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A82C19E7D3;
	Sat, 11 Jan 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lx48/c5b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7gYnvr6t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBA1F16B;
	Sat, 11 Jan 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601690; cv=none; b=R0gglB/XUUHlrruzx465oNXLWPh7rel/YnmJYiA6EzUeQbQPmkHwK20gGMmUqEnrG50DiXBlNHV0AWLixs8DxPGhLzus53F3Ox9P+QLLwvooFa9AGishk4a2hlK8Z/JyQtK6sK7ZU1gzS0ROAXxLPuGvmOLKSAoRM0xXF6BvS94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601690; c=relaxed/simple;
	bh=17kPLYuTrrdxHRKb1jIu0FsNCo+SD1PZr1AOQegIFQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oHM78NdL7cKLe4xIxlCi/835IVt30b3JnLqkevW7NxtEUSmAWZjpKyGpamgJ4X8vf6I2C6kV1lrD4fbwXADc0xEf+3/yETE+bkkPOHDBDwGpXwfXyVT+p0z/aDFK8ksWDwNiMP0wDOASIPToGOoK5Ew+Lp13lK5+IeQ1wJmNxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lx48/c5b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7gYnvr6t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 11 Jan 2025 13:21:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736601680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DSSAAFH27seojboEFMyPbZPQvBq15dnAim5gY4+fls=;
	b=Lx48/c5bz6GykMMmxb0MwVuCPoRtlKI1ty928PtumzY8DoiTPe8MDs53CZ4Ukz0t0MByr5
	PxpqK6z58yKnDEcsIrOrZ9Ijo1aZIKCA3RS5s4pPn3M88KC25zgCzu9NI++I9HQSPSB+17
	sohHsibGsQs7ICQswQRbuMq9mZ+h7LAa44HPgDxvWmncJ06ieCFiv+SiJFJoeHMknnGv5n
	k+rj8DN4Egs7oS3RYcxE1zQftkxKQviuV+R6DXX/otBUjMNbYgsQrdXEuwCYpACTBE+gj8
	rJKfmFdgDcqeLIXRvNx/5K92L5kedQ/u7u/jSttXQrGXarPp+mffWVmtVTOI8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736601680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DSSAAFH27seojboEFMyPbZPQvBq15dnAim5gY4+fls=;
	b=7gYnvr6tbyGFd65EwhmIvP2EdVjHFOGon4FtKsbgB4+ar82wrfANqdcCUARpqQkFLPG+WF
	1isk8X6ml/J0WZBQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] MAINTAINERS: Add static_call_inline.c to STATIC
 BRANCH/CALL
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109114703.426577-1-jirislaby@kernel.org>
References: <20250109114703.426577-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173660167699.399.12732691294821815631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cb4ccc70344c3dc29a5d0045361a4f0959bc5a6b
Gitweb:        https://git.kernel.org/tip/cb4ccc70344c3dc29a5d0045361a4f0959bc5a6b
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Thu, 09 Jan 2025 12:47:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jan 2025 18:16:48 +01:00

MAINTAINERS: Add static_call_inline.c to STATIC BRANCH/CALL

Commit 8fd4ddda2f49 ("static_call: Don't make __static_call_return0
static") split static_call.c and created static_call_inline.c. This was
not reflected in MAINTAINERS.

Fix it by changing the MAINTAINERS line to be a glob: static_call*.c.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250109114703.426577-1-jirislaby@kernel.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bcd4e7..7da973a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22450,7 +22450,7 @@ F:	arch/*/kernel/static_call.c
 F:	include/linux/jump_label*.h
 F:	include/linux/static_call*.h
 F:	kernel/jump_label.c
-F:	kernel/static_call.c
+F:	kernel/static_call*.c
 
 STI AUDIO (ASoC) DRIVERS
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

