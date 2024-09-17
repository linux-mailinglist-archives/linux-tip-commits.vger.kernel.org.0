Return-Path: <linux-tip-commits+bounces-2306-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF6597ADAC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Sep 2024 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3405E283F8B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Sep 2024 09:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8169C15C125;
	Tue, 17 Sep 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+fP7bej";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JE/U5ewY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D113A3F4;
	Tue, 17 Sep 2024 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726564548; cv=none; b=qcjXinzMtHP8rUuxcmL7ZBPYat9QtUcA9of7BvIjb/QH1amn0rg0lMm87ArIxhAsW0mDkE0SpEbpRGij6ssq7nEC+fI8P8e/Dk1qZljBhhH6OYzP8TjOqSWH5bE3d7w5UbA8y9x8LTA4DT4JHikvQp4NaCYF3Qhro5FkV/ALuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726564548; c=relaxed/simple;
	bh=M2MMSOsizNcz1fTV6Lq8yK9IAN23/mrs02gEbgn5GCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GMm3DJE+B4AKu1rupoc0IKYoN/0qPqk7sqahp0ZZeh1qfMdsRMMNepH5DcD45rZCvnNYKXwD9gabrKbLWZiMQJrL+a4xDJA3TyuqpLE6H6eMjL316/P2PgCy7vWnAvKNjSiW95kHI224EcFqkxNnyNxEHlOz1wb4fCfLwUs3o88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+fP7bej; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JE/U5ewY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Sep 2024 09:15:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726564545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7g4Kmg8lanYNC6phsFV1h8YkZLl6DTVpdNGuOlDX/w=;
	b=p+fP7bejab3QyED7MJcUMYI+fXW0WRbNmGXSmBirKMHINha8vGaVphfBqbEmYmzJPxMigE
	dl1XhkU879wgwDgHS3NJ2qRbPMXx8SZ2HvBNqNo+se7f1/Jgn3iyTP5CZfBqk2nRCiqxC7
	K/xwT5Qr/LSJoQGsaT5VlJKkGNtI1vKscK57pZh1gVRB2THvFrrHJoHx7e22TXrbMDRr26
	j/GCoPohptrRAqRIghTRCJJmU61kgdoMt1ASwZqyOxk1Sks/zgGzgW6VLC5KzpFpjzsU/p
	/fuBWFTfhvq91bjxrjKxLQ2uxYmwFructh6/SfcaaO9eWG7QkrW/VLBkmZ7Smg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726564545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k7g4Kmg8lanYNC6phsFV1h8YkZLl6DTVpdNGuOlDX/w=;
	b=JE/U5ewY5BtFzPD5PegpcNhQByR+k2+uFDOhJ35IyN7ZogivCTS1tWsratESgfZbt7sPAw
	3vS+zm6QNkP3xoAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] x86: Allow to enable PREEMPT_RT.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240906111841.562402-2-bigeasy@linutronix.de>
References: <20240906111841.562402-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172656454487.2215.2022637587652544393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     d2d6422f8bd17c6bb205133e290625a564194496
Gitweb:        https://git.kernel.org/tip/d2d6422f8bd17c6bb205133e290625a564194496
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 06 Sep 2024 12:59:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 17 Sep 2024 11:05:53 +02:00

x86: Allow to enable PREEMPT_RT.

It is really time.

x86 has all the required architecture related changes, that have been
identified over time, in order to enable PREEMPT_RT. With the recent
printk changes, the last known road block has been addressed.

Allow to enable PREEMPT_RT on x86.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240906111841.562402-2-bigeasy@linutronix.de

---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6f1c31f..865573b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -122,6 +122,7 @@ config X86
 	select ARCH_USES_CFI_TRAPS		if X86_64 && CFI_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_SUPPORTS_RT
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
 	select ARCH_USE_MEMTEST

