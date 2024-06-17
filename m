Return-Path: <linux-tip-commits+bounces-1421-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5C90B2D0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22441C20B6F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5FE1D327E;
	Mon, 17 Jun 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMYDluP6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yCfivuml"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950D1D5423;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632281; cv=none; b=fsu+cW8QkbOc+V2HHfYTRHYQtzoLJQZTZI/erf8vrZmIICaYXs1q/AbA3BO32yUh5/G9C0y0AuCUhEe9tttujdnHARefjdecowQ6wSxFc3oaX23Kf+qWv9sJ/qTUj4nbvLNUWudcaI3zUWlRy5Ag7eW85CRbSIPF3QZGXx4klTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632281; c=relaxed/simple;
	bh=5sFTB+c3HM5d9sJ3hXGLuMjfEJj3TneeZEhBFbWmAGQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FyP8CqOtsVoUYspEnvRsAzPLvOoqhtGonSfbl/aHyOayoMBdxKO2PB2hfzN4fqkjU2VRjQjlJHrs7lOmaE0gLNI7CpT9zrPBapy5Ri5hf9uqo5R7l5BpS3mz4kYTcVdRbpvKj/JjN3r4AYFlPF5eiRYWTAYPq6dSKxXKgOFynpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMYDluP6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yCfivuml; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeSHOZA/qzmsMTTXVq+UsV8WgDCf8U7fbDbNS8Y0SzQ=;
	b=gMYDluP6oIPciJCMQMjGU3CFctLPYa++Bq8Ga+Y1qjSpENl9HAKRcTnj8XjKmn0/2fnl4o
	MRHE7DUWh+z4a1d0lFY2zm+HugdKToqCSrcK9Q3rl/azCY3SNJNvwCPtpqC3bNVoYqZOTa
	04lBnN2T48clpeEYI2GY2tVjhigjKkoLR6dcfDhkGK7ooABFqMogr2I8zgfGEAFXQVUsNg
	2p7/g30sfL/J/Z+iDme8FTCcg6bcJDsMxadpWU+DWED1IHuLPRhEEA2W0yPKQZmziGRypP
	bH/xCMRX4pV/oGodP4qhyP2ByDNrDsBJ5E+i4jr/lhg8S+CafGzSH69snCcbIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeSHOZA/qzmsMTTXVq+UsV8WgDCf8U7fbDbNS8Y0SzQ=;
	b=yCfivumleL/EYND1nQmDAxxDE5s+zKGn883JTiDP24/8NMefMrjEfhfNrJm57GUnbKP53D
	QJOOUucu7PJ0AEAQ==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Constify parameter in is_fwnode_irqchip()
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-5-herve.codina@bootlin.com>
References: <20240614173232.1184015-5-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227333.10875.12636924524837233445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     922ac2cf9fe444c4aff165b9f7e158a9b651647d
Gitweb:        https://git.kernel.org/tip/922ac2cf9fe444c4aff165b9f7e158a9b651647d
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:13 +02:00

irqdomain: Constify parameter in is_fwnode_irqchip()

The fwnode parameter has no reason to be a pointer to an un-const struct
fwnode_handle. Indeed, struct fwnode_handle is not supposed to be modified
by the function.

Be consistent with other function performing the same kind of operation
such as is_of_node(), is_acpi_device_node() or is_software_node(): constify
the fwnode parameter.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-5-herve.codina@bootlin.com

---
 include/linux/irqdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ab8939c..a3b43e3 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -314,7 +314,7 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 
 extern const struct fwnode_operations irqchip_fwnode_ops;
 
-static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
+static inline bool is_fwnode_irqchip(const struct fwnode_handle *fwnode)
 {
 	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
 }

