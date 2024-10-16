Return-Path: <linux-tip-commits+bounces-2483-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5BB9A134A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7E7282E55
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F0921A71F;
	Wed, 16 Oct 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EgxEK+hr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ywvmFgmx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893C521A706;
	Wed, 16 Oct 2024 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109064; cv=none; b=CQBlsib+ifKMK4dWLtwevQklPf/l/kyqHz/e86obEgxdWOsXt22TKP16uL7t1ECL6EwDErl98YYisoT0JCKj0ajsNmSU3NOtnX3EuEhvexBoxo1sfKT3+O2PiVY42QANGO7OeoRFEo5mlvuNaBoMoprmKZ0RuXljhVUOLe6lYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109064; c=relaxed/simple;
	bh=C8IB3IHwzyzVGdE5eFYL7H3ZQQ2J5MBMalPlKR85FAs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z7Up/NlEKUKdpDv7XEYrXW0KJWSkgipY/z/bCcW7arP07C2h2EV8gSTqpCSPQHqZQQRSTkeY/ssF64YJPUDA7CHrWtWn4sKPklydJ8fisGs4PQq+CXGes6Kdh/5pmIo4aQA+7MCjb5Ht4sQyn/0vasOW8jihTktACtpfE8lk8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EgxEK+hr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ywvmFgmx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tMHmBDxuN+GHMO+UZR27yyhrnh2wfi/eF5L0JxzAl0=;
	b=EgxEK+hrpTR467aMvhH3zuTvadzM51dLtCrBwA1hWKT4m1i/Db3uXvM8mK+k72o4FZsYj+
	gaGBbdZ7nzbfBIcod/hO4VVOO0a9hH3VW3R8M/SecZAI3SZD9lQObCOZHOzMpCI1XqiTfk
	YctSYQlYfzQgsoPyG13L6zoe1ClMmV3gSqUkQeh4G/4Khl0NkdtyhxTowuWnQSOt4VRbnq
	yQisKuFBGrduz0Exw7YlWIofvRQVK7OakEq8v4XdBj2Fc5/RFAKM1Bjn21c9xLvyDOgzoN
	Wf9u4TVRjgqpnXVASa+bcBFFQuZHlWVlX3FdM5bE/clmebJBzOB76a5Y6i54Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7tMHmBDxuN+GHMO+UZR27yyhrnh2wfi/eF5L0JxzAl0=;
	b=ywvmFgmxWUHRzWv1sdag9HcelcKd5PeGMV5JsOzarcakKnKd/SKz47kv6Nk/1WmsbEhnxC
	ArEnNnod29/5x6Bg==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] net: hamradio: baycom_ser_fdx: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-10-bvanassche@acm.org>
References: <20241015190953.1266194-10-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906009.1442.9041555986063674589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bc6e6f07ebeda52e9cd515a11f62c6a6abb6f50a
Gitweb:        https://git.kernel.org/tip/bc6e6f07ebeda52e9cd515a11f62c6a6abb6f50a
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:40 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:57 +02:00

net: hamradio: baycom_ser_fdx: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-10-bvanassche@acm.org

---
 drivers/net/hamradio/baycom_ser_fdx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/hamradio/baycom_ser_fdx.c b/drivers/net/hamradio/baycom_ser_fdx.c
index 646f605..799f8ec 100644
--- a/drivers/net/hamradio/baycom_ser_fdx.c
+++ b/drivers/net/hamradio/baycom_ser_fdx.c
@@ -373,6 +373,7 @@ static enum uart ser12_check_uart(unsigned int iobase)
 
 static int ser12_open(struct net_device *dev)
 {
+	const unsigned int nr_irqs = irq_get_nr_irqs();
 	struct baycom_state *bc = netdev_priv(dev);
 	enum uart u;
 

