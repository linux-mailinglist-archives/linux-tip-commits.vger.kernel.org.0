Return-Path: <linux-tip-commits+bounces-2228-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F1972095
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B66285CD1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50558188CAF;
	Mon,  9 Sep 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDtFlb5W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aYBQmRru"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9EE187848;
	Mon,  9 Sep 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902871; cv=none; b=Nvz4xCeiwe9VzEswcvGWXuuKnHxURVWlgL4s9NDJWzRXoCnD7TzmsPPjc5BX6fQQh8C0/xo8xBpZi7wVxeUnBoeSGOjJxKK0R/6QscO7ixxNGhej+FE6mUP3oGGIk1WqLFgp4gOt+gheWgeq9HxZx+FSYvnhciHvVavHMeWphUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902871; c=relaxed/simple;
	bh=jfsb6GIAxhz+XyuprzriE8CkIeOeiVyHrVvbKjHgRBA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cspWhX7CLhxHQPmPZwRuyMAqrrUfY/6HHdKF+3JFztCa2FqX4ltW0TdnJOsM6FhDu8uJZ43aHq2tqJdcell0uvg0DE3FJq+EhhPWBCk5Bx2Bttmf2mcTExWR/kcjBeJLLWnJiGYLep+BibU7ojFpG2jPg7U7wz1o1CepVDznrh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDtFlb5W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aYBQmRru; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4gJ7K8qV+Sv+9nfgqu3/MTTh0ldMe2iptH/NMPVCBw=;
	b=UDtFlb5WtQ5YU9P+wcexH4GTpfhRSFb7mjkfnB7JyNROWSL91PX5SN08LYJzBzmJmwmmML
	vUwjcfXJorGwgUQiSJexTYnafOQaxupppjoIK5l4aXWt0uRzTnqmoZ/avZf3FOsCY6n0qd
	2hTZroueAWpmW7faRtBgcuY4r5jmF8TVDdlOegyOPdDEujNILJf1lkUPCnxdPORjK3lkPH
	2tvL4bZPpn1+BtwazdNKIfTbYiUf8dYmBWTu5LGQA8/o0QSGRN4eIc5k1mprRIV8axYuBr
	UXsFdhZNX9heyPJfctKnrQjTLWITOTzxcQYJ3KsFtonAtJ5aGg2ssKOGVEvC+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4gJ7K8qV+Sv+9nfgqu3/MTTh0ldMe2iptH/NMPVCBw=;
	b=aYBQmRrucsjq5XVZEN7FVZG4Af+hLTfy0IftnivN3QtRdrwfx5S9uywfgJasYg4bY4EcSl
	o7GVbaUUTgQKanCg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] printk: nbcon: Init @nbcon_seq to highest possible
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-6-john.ogness@linutronix.de>
References: <20240904120536.115780-6-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286579.2215.14643543516807543245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     fb9fabf3d86216961d1103ecbc33e98d5f6c48f5
Gitweb:        https://git.kernel.org/tip/fb9fabf3d86216961d1103ecbc33e98d5f6c48f5
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:24 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:32 +02:00

printk: nbcon: Init @nbcon_seq to highest possible

When initializing an nbcon console, have nbcon_alloc() set
@nbcon_seq to the highest possible sequence number. For all
practical purposes, this will guarantee that the console
will have nothing to print until later when @nbcon_seq is
set to the proper initial printing value.

This will be particularly important once kthread printing is
introduced because nbcon_alloc() can create/start the kthread
before the desired initial sequence number is known.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-6-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c             | 8 +++++++-
 kernel/printk/printk_ringbuffer.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 88db24f..bc684ff 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1397,7 +1397,13 @@ bool nbcon_alloc(struct console *con)
 	struct nbcon_state state = { };
 
 	nbcon_state_set(con, &state);
-	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), 0);
+
+	/*
+	 * Initialize @nbcon_seq to the highest possible sequence number so
+	 * that practically speaking it will have nothing to print until a
+	 * desired initial sequence number has been set via nbcon_seq_force().
+	 */
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), ULSEQ_MAX(prb));
 
 	if (con->flags & CON_BOOT) {
 		/*
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 8de6c49..4ef8134 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -404,10 +404,12 @@ u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
 #define __u64seq_to_ulseq(u64seq) (u64seq)
 #define __ulseq_to_u64seq(rb, ulseq) (ulseq)
+#define ULSEQ_MAX(rb) (-1)
 
 #else /* CONFIG_64BIT */
 
 #define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
+#define ULSEQ_MAX(rb) __u64seq_to_ulseq(prb_first_seq(rb) + 0x80000000UL)
 
 static inline u64 __ulseq_to_u64seq(struct printk_ringbuffer *rb, u32 ulseq)
 {

