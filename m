Return-Path: <linux-tip-commits+bounces-2474-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783909A1334
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8008AB20F8C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C9E218304;
	Wed, 16 Oct 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWVC/ByQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2yyHW2R+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90D2144D7;
	Wed, 16 Oct 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109053; cv=none; b=ftTLpMyZQGk2M9e9I4RbJoG/xS8vbKhL1qKOu5CEkFuuv+ZRJhUp09Isbt55ySle1zo1l1g7pANIujEdQs5EDqbfi921Y58NflBPdNXcG0sw9pbSDfQBYg1LsvJbXtFJg8VVy0eX7fjG919zrqu4D9Rp+wPy3XYlEqgSqL/BfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109053; c=relaxed/simple;
	bh=xtLV7cefUt5aM7b+i0A7z0Gnnjq9yi2TVmAgpeJi5Hk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p10aPoKDIZAXxnCzFqwvUkZE7VFN5f0AWFNAlCrS2yiLYAXnVVkm8mVsP0gpNs7GClfbiIZyuRhEsMMmjn1Vd4K4WLXuJReBICbo2ov5LO4sGZ/Gz5nE4tjiocwkHVQkyhlGWqXcCrRmHKw3cyeXgzYcn/Nl/uIhuFf5+rqR9Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWVC/ByQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2yyHW2R+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9NLwdQCvNIEEG390SWc0AqLXbSQdSQ0+3rPSpu25tQ=;
	b=HWVC/ByQ4mSoqwOsSWEY0CvfC5No9Fz01v6DWUo/Cp9yOCnxluDXgktIENRqwF+b+mncI0
	3dMXXzOvvjy0jko/NIhbbU57FJbd35C4jykSmATyqX2C4AEhzrHpg9eRtncwbflZSclFkW
	AikPYG2ramDIF0b/tXxc2zywlrTrNZqLSPtYPuqK/hvVP3JPAflzf6iZhWu7K/pwJAjo/U
	Z2YCNsUvL5osKvFE0t7MNJdi5U/N6y0Z2hfN8WzNv5sLEG/uP/sMEj4s4GVkLiJGMawMQa
	deJLnnVf3ycF+kJRSGLzkbD5vTzOPYQ25bA+dt+F4KNC9XfInDrS/ER37J0zVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9NLwdQCvNIEEG390SWc0AqLXbSQdSQ0+3rPSpu25tQ=;
	b=2yyHW2R+ZTeCIGIkeoQSjjd8FpuEcak1pc5Js2IXyQoC7NiqpX2gmhS9gx8Pew8JthzDAD
	gQVf9ayl9WJ6ApCQ==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] sh: intc: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-19-bvanassche@acm.org>
References: <20241015190953.1266194-19-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910904853.1442.9554395199038006596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d0c62d51ede0718203502c192665e1d379fbf207
Gitweb:        https://git.kernel.org/tip/d0c62d51ede0718203502c192665e1d379fbf207
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:49 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:58 +02:00

sh: intc: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-19-bvanassche@acm.org

---
 drivers/sh/intc/virq-debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/sh/intc/virq-debugfs.c b/drivers/sh/intc/virq-debugfs.c
index 939915a..5dd8feb 100644
--- a/drivers/sh/intc/virq-debugfs.c
+++ b/drivers/sh/intc/virq-debugfs.c
@@ -18,6 +18,7 @@
 
 static int intc_irq_xlate_show(struct seq_file *m, void *priv)
 {
+	const unsigned int nr_irqs = irq_get_nr_irqs();
 	int i;
 
 	seq_printf(m, "%-5s  %-7s  %-15s\n", "irq", "enum", "chip name");

