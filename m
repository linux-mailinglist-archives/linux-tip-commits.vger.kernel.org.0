Return-Path: <linux-tip-commits+bounces-2236-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C99720AD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101ED285618
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50882189BBE;
	Mon,  9 Sep 2024 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFpCOkWP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0g4tMfYk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D91885BD;
	Mon,  9 Sep 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902874; cv=none; b=Zky6FQPoa7thKXYiGfWxHKQjp26T4zNruE1kdCZ7BrEIXjiUV1FlA0Ymd0/on0An9qQZDz5O15QdJ03GkSBzGMTrlhVZPWTYQYDHgd6SzxZSuob3rleqb8K/JQD5tH38o8lcnsk9VlomqgM9Vt+dFl97ZNfEE85SO53J4Q+YuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902874; c=relaxed/simple;
	bh=leFUnp+nHuG/SwEufuSg6o62O/35kTWnsr6kVoBTNVI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aseST021kPetpZJsLo4sLQurLBLP6B3A3musz9MT/9pkgeBIVRnb5kvvozxceBqvkUuOxlOLPgV85D7QadbMTXsJgMOm7skKjxkGf3rWUUUjHT5obt5pYh6o7m34dG09hcqj9y9ElNV6WZJKNIRc9buHZWrc5xQ2w0Ac0FMCeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jFpCOkWP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0g4tMfYk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRK5ibHJ7wOCcI6zgjkU92JK6o3p+DbygDwIT8SuAwo=;
	b=jFpCOkWPZ2XdrNbZKUNHIIS7z2Wwc6r91fpjr2Zty+/RdS4C5MWD1dwnOpeVwDEC2btmy8
	8ckHaAgBIvZ/GqLUMRXD7m1/cbrf1a+of8r/oiEbYpOCbIxt0HVbd9IJm82KMT46sTAN+V
	MZxU98UzjlbBqrbEQgy5rk5WJLh6Wr+hIfEp8K5hdLT1reGgGqOoFoA4gaz6HQLljo37f2
	QXksVzGToAYqD/XEVsYOxfSrFgNMkgpiOCDfBKhw0zBW6XoKcLjGGorH8mXWfmWt+rbXoU
	JDXItNTXGkh7/4yDEoyMl1G27UpFRc9zi4pozugwzFNO7tkW0/NM2ayyBkgnMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRK5ibHJ7wOCcI6zgjkU92JK6o3p+DbygDwIT8SuAwo=;
	b=0g4tMfYk52qf8+IKgQOYzvg8ijct+ytxbsuz3qBaFzTvSp6b9acgFnjNRZUxRjKsTLkvdN
	X2iwt/4daxs3loBg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] panic: Mark emergency section in oops
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-34-john.ogness@linutronix.de>
References: <20240820063001.36405-34-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286883.2215.17184997422421040853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     4bdfa0d8e920c391e6cc0aa1feef8ed91d81f724
Gitweb:        https://git.kernel.org/tip/4bdfa0d8e920c391e6cc0aa1feef8ed91d81f724
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:59 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 15:03:04 +02:00

panic: Mark emergency section in oops

Mark an emergency section beginning with oops_enter() until the
end of oops_exit(). In this section, every printk() call will
attempt to directly flush to the consoles using the EMERGENCY
priority.

The very end of oops_exit() performs a kmsg_dump(). This is not
included in the emergency section because it is another
flushing mechanism that should occur after the consoles have
flushed the oops messages.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240820063001.36405-34-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/panic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 1a10b6e..753d12f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -685,6 +685,7 @@ bool oops_may_print(void)
  */
 void oops_enter(void)
 {
+	nbcon_cpu_emergency_enter();
 	tracing_off();
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
@@ -707,6 +708,7 @@ void oops_exit(void)
 {
 	do_oops_enter_exit();
 	print_oops_end_marker();
+	nbcon_cpu_emergency_exit();
 	kmsg_dump(KMSG_DUMP_OOPS);
 }
 

