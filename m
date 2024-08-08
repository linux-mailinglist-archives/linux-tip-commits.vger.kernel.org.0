Return-Path: <linux-tip-commits+bounces-1995-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ADD94BACA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C35282ED7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7BA18A6C2;
	Thu,  8 Aug 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScWaaUTz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V13EMX7a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DF189F3B;
	Thu,  8 Aug 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112567; cv=none; b=PnHdoAcHthgv+9Lv1V0J3x4gYScqLGIvdRlDzfJL8TKbkh6LagPXuo/A3eeY36iEWc7oVJCIqaowYWO/Jvd4l7lyw4zHfZMIGoo2xAAxxsSfEna3fcozUD4GFMVE4uidv06xGJ3wflr9SqP98DEu2mv6x6lJILRF9ClnmrE1wyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112567; c=relaxed/simple;
	bh=ay8fpRPUhdlevOPxpU142NF/MCGOF60r6TCTEfWRypI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kOpwiThPDdvnldhi1K3wNMQ8Xcp9F8M7yDVzqSq0/kdnNRsz7ytm5v+Wqnsi9h5HUVzxOaV34o6iLjtK7MTYcvpA2Au9mnDsrjQQdq8RTZcySzNo93cGeAhuDyOv97TqI53uMzgkVdflSFTbi3kBhNgpKfJBEsOqsObVvYLhoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ScWaaUTz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V13EMX7a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:22:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723112563;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41r+CqkBJCQpEyu0WXdNc0nBJYU7r6CqKcANyHYGV7M=;
	b=ScWaaUTz9/3rJBvKvBO9n3WRtOPWcb/VtfkLYtXnRfeytu50jZTB5cEjmZepa4jRq+p5R8
	LJaKv/LEWuJM83QpBGDMQDOgCQ+z8Blye25+Z5JjSnwGPY+Mhx0fPMQ+n+RsDH9Lzbb0ak
	n5quwogdSD0QRo1nMi1OYLkn5SGmZ0RB77jwwiTrJUQZi4os5GxIpzMryVkryDuhPkOOGi
	ZJYFDpkKZDWHJe4y3MemufuSHkyb4X1RGmS3PTEGI6OSWjTDn8pZu/MB3d11fgMomoFDRG
	2GUabkglXcuAm/aTDPhxdGVq6mIKcQ4nfJluGb5fWfPL43bOnlLb2ucIVmHmYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723112563;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41r+CqkBJCQpEyu0WXdNc0nBJYU7r6CqKcANyHYGV7M=;
	b=V13EMX7aTs2XY7PVvPRpS1k0hnjCL8FrWXV2/isEqk6ngiPzKbgHUdiWxIT6GaS1F7zqmU
	tCXE/5W6UjQvyVAA==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] lockdep: Use str_plural() to fix Coccinelle warning
Cc: Waiman Long <longman@redhat.com>, Thorsten Blum <thorsten.blum@toblux.com>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240528120008.403511-2-thorsten.blum@toblux.com>
References: <20240528120008.403511-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311256267.2215.17125576350674011686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     13c267f0c27e35ee9372d3cf0dde1ea09db02f13
Gitweb:        https://git.kernel.org/tip/13c267f0c27e35ee9372d3cf0dde1ea09db02f13
Author:        Thorsten Blum <thorsten.blum@toblux.com>
AuthorDate:    Tue, 28 May 2024 14:00:09 +02:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Tue, 06 Aug 2024 10:46:42 -07:00

lockdep: Use str_plural() to fix Coccinelle warning

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(depth)

Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240528120008.403511-2-thorsten.blum@toblux.com
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index fee21f3..266f57f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -785,7 +785,7 @@ static void lockdep_print_held_locks(struct task_struct *p)
 		printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
 	else
 		printk("%d lock%s held by %s/%d:\n", depth,
-		       depth > 1 ? "s" : "", p->comm, task_pid_nr(p));
+		       str_plural(depth), p->comm, task_pid_nr(p));
 	/*
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.

