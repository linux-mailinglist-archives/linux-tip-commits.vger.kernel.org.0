Return-Path: <linux-tip-commits+bounces-2259-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD59720E6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A651C23AB6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89E418DF94;
	Mon,  9 Sep 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UGi4j4b5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+klmjJJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22618C900;
	Mon,  9 Sep 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902881; cv=none; b=mFbdGdz28nVC6ZTW/kNGD9BOb6EykP921xAoXS9j7OXvBum6mzkCS7pA+0LkNT9VZK3JKYhbE/G0CYWHqfJmXsAPuPkhPSahr82CnjxHH1K+z7P3+YE8CXmKLTxmHawkVYl+9AgtbY0erfp8wgvwUkhf3QieeZFfQZgSmAXwsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902881; c=relaxed/simple;
	bh=A+rOFsRcpdka4YwmnbpYgTcBPKJSXENn8JPZNc2rjMk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OAQSxdxIR1U8oA2tn32eR+jCW5onGZhrtmRhbVixb6r+mhIz3Y97p7wkgbmAGUsW+rSbHnLGZ2P43meyBvSyXblz5/LAW2qyi4buwueytadkyv1KKTQ9q5A+KhPQzL1VRBZOw/TNl5FDbh1hvXUdjMSYcUfyLNokyWvSXCToyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UGi4j4b5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+klmjJJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93yBS+Iz6bk4WuRM8FXbQZ4lUnL6TiPv9B+tzlD4uQQ=;
	b=UGi4j4b5+9jCmgQ3R17YNRgh74P2l6vLToqNXFUhBkz1bZPhIuC8pUG4XwtnBKdyUWp+pQ
	zrJg07nPt86si7z1dI/52swihayUpoVYs/3Rc70TyNh0fzaVpi/lZbcP03lZmNKwtpDHQC
	B6pM4XgaTfl1tQ2R9i5/EzMGEtVZFS3lZXPSnWOdxOAzUuToXXBhxr0hhqQTK26ZcJ2MpD
	bXT4WOsKASh+yqQtf6v2pHFcDh871TQUo9M+kSzZ62z3n0VktNhXaMs7AStyt6wCUHc2FI
	2yGg5dX6ga3xAO/6oYRmk8F4bWCXDV71TJvTNJrDO2BP+2wMMTVCubYVnLXHnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93yBS+Iz6bk4WuRM8FXbQZ4lUnL6TiPv9B+tzlD4uQQ=;
	b=G+klmjJJiRkTWOJ1xj1WWv2XBa+9EV59tjK+JbK99PAFoBQUjq1dbdig/kPj1mfLkcuTCT
	DTamRkPE90a3hBBg==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/rt] serial: core: Provide low-level functions to lock port
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240820063001.36405-11-john.ogness@linutronix.de>
References: <20240820063001.36405-11-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590287704.2215.4606134704814896301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     77e73c0687f5bc884fa1b0cb97aca912bcc01957
Gitweb:        https://git.kernel.org/tip/77e73c0687f5bc884fa1b0cb97aca912bcc01957
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Tue, 20 Aug 2024 08:35:36 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 21 Aug 2024 14:56:23 +02:00

serial: core: Provide low-level functions to lock port

It will be necessary at times for the uart nbcon console
drivers to acquire the port lock directly (without the
additional nbcon functionality of the port lock wrappers).
These are special cases such as the implementation of the
device_lock()/device_unlock() callbacks or for internal
port lock wrapper synchronization.

Provide low-level variants __uart_port_lock_irqsave() and
__uart_port_unlock_irqrestore() for this purpose.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20240820063001.36405-11-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/serial_core.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index aea25ee..8872cd2 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -590,6 +590,24 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+/*
+ * Only for console->device_lock()/_unlock() callbacks and internal
+ * port lock wrapper synchronization.
+ */
+static inline void __uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	spin_lock_irqsave(&up->lock, *flags);
+}
+
+/*
+ * Only for console->device_lock()/_unlock() callbacks and internal
+ * port lock wrapper synchronization.
+ */
+static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
+{
+	spin_unlock_irqrestore(&up->lock, flags);
+}
+
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure

