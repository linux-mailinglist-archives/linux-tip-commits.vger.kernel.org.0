Return-Path: <linux-tip-commits+bounces-2219-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0B972080
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 19:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBAA1F247AE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D06184549;
	Mon,  9 Sep 2024 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AUSFueu+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ndUyk+CA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695517D373;
	Mon,  9 Sep 2024 17:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902867; cv=none; b=qKmVuPrKt0t1sdY/YT86kgaaOLaiXEk9RmCKFamrQLKgQUGzLxy/ZCqtpTb50nKNh5yj8E7cvkJaFPZGON4di5CenOnbn4GxGsrvNnMA7Xa/ujuIbo1J07GYjJhtZTQo2rVbcZIQejx4HlHfkiiR7lb/rbUAtmeoxfuotTg0bxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902867; c=relaxed/simple;
	bh=jXUifFavuFbbTYlxNykmLtoxBQBs5Qzx8YeUPP/8lvE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kLdd/OjzyFjesMYbz3tTPk4t4kQRvjQOrYK0ZdCdYxIlyKGQy6zZCKUaGxZw2a/PqVjdqASzX/H+THSp3bcpEYPwlZQpnX+isDcdIDHMQ5MzEMuEpcpsy9LtCYHhKM/Is2Yw2ABXf8IUJyqtcbfPGX1+h/WZLXcmeoeKFqMFcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AUSFueu+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ndUyk+CA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 17:27:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725902863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QM5+U/+XE23T8vQXBt73c3VGqrH8NdSsONu/3wYr+KU=;
	b=AUSFueu+tvAwDLFkD1cgrcS2axHvYQy7i8rC7ntzKqiPMcd6JVliwyNlB0+Sb+nI0n6Bc+
	kxX7f+/toSsknbzvEyRck1DeF1D+La8sYvDth5fxX2Dm51UJXFQnw0hBxHKDaQ1/mcESPl
	Q9pXVoUDZnGqAd0tBa6I2gwq2Y85ekH7trm/+Sug7EkXtqN+wWajHxzZETRv+zc1vTZGgw
	QE0XFRnrSlGOxaAiSnbhvn60WNhW4mz6zxSPRfGb2IY8j4jWSUkPwpSI82WYOTh4DQXxvI
	uXi3ZHEqkjEZbeYsbzc9JZ0vvpok4Vp1+G59ZzakLMbrW55C6fsqGP52SdEvLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725902863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QM5+U/+XE23T8vQXBt73c3VGqrH8NdSsONu/3wYr+KU=;
	b=ndUyk+CA9yy+nltzkEg8vNeqGGzlMTbCO3VmW294Ao9rbsufGs0rt9MLVNF5b/WWtxyIzh
	tbma9VA26Jkl5PBA==
From: "tip-bot2 for John Ogness" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] tty: sysfs: Add nbcon support for 'active'
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904120536.115780-15-john.ogness@linutronix.de>
References: <20240904120536.115780-15-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172590286289.2215.10873768442218970013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     def84b4467771d0ea0b55e6a5d0d70eb54bdf46a
Gitweb:        https://git.kernel.org/tip/def84b4467771d0ea0b55e6a5d0d70eb54bdf46a
Author:        John Ogness <john.ogness@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 14:11:33 +02:06
Committer:     Petr Mladek <pmladek@suse.com>
CommitterDate: Wed, 04 Sep 2024 15:56:33 +02:00

tty: sysfs: Add nbcon support for 'active'

Allow the 'active' attribute to list nbcon consoles.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20240904120536.115780-15-john.ogness@linutronix.de
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d8..9140825 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3567,7 +3567,7 @@ static ssize_t show_cons_active(struct device *dev,
 	for_each_console(c) {
 		if (!c->device)
 			continue;
-		if (!c->write)
+		if (!(c->flags & CON_NBCON) && !c->write)
 			continue;
 		if ((c->flags & CON_ENABLED) == 0)
 			continue;

