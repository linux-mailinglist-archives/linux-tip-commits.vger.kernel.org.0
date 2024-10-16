Return-Path: <linux-tip-commits+bounces-2472-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA59A132B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281C21C2125D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F3215F52;
	Wed, 16 Oct 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HF5e+r8B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDLQMy/a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35C1C1741;
	Wed, 16 Oct 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109050; cv=none; b=M3ai0+ASnoUUTI+VWSJbkDATFhz66DGUh03S0Sy2scly5eYo5NRhgWK/QnQHMY8eFacwtOzBJ44bTLf3iLbOT+Olfy49/jRIkJ95SlWp49bx/1o8Yy4jaGNEnWA0owADg6C/A9WQTbH7AkjLll7gcfZDdCaqucvZqA8mesHtcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109050; c=relaxed/simple;
	bh=tuaO6A7gHLNmvnHus5eMRzGDum5IqO8lr2+Aro3Ykjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gOM/sU8nDYNWtKPM2wnoD3dap7iQ9VzHumg3uWRDzOOIjftgoQKoHR6Bm7fKcsygdItlrqv6yo/f7W0P0q9NoHpKN4Wh3n3oeylrPyaXKCG8BEOQITyG2RGCiVnEqJ6lvdWQ2wfZdNcl9XzMxQ7pIfhOs/QxoVxLedAyh4syPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HF5e+r8B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDLQMy/a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2v9s9xAb9zPgs8gsAoEXm6oEFtD6sxRNKgOYIgaFYE=;
	b=HF5e+r8BNAzUsMfxwol0LnQeyf4IXmw87rNrGSreoNyXE+pYwDUggAX6tFWk8Wml8/Ngbk
	fd2q+RRPa1SsP9Z+7+4PO9hC9ypGp6EtdeOwvgjV5gBUDvg+Iyez+wvbCG+chjGan6wBDw
	gO7tQkdua1IOLGbXULpGvRJUlgUFZO1Pwet1JDQ353YFVIMUGeKiEn0hDsUXMXOf+E3GrD
	6Sf7z0wH2Ga/0GkbxAADaIVGTFMIv5kyTYiLDHG7btmPi3Nm1qNtI/7fgGwX/Q1/4rXT58
	J/cM+7D3uxIzDD6jAj2nv3bsxcusiGy7a18sMKdPVdXyNKwIwdRpHSdNx8LzKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2v9s9xAb9zPgs8gsAoEXm6oEFtD6sxRNKgOYIgaFYE=;
	b=EDLQMy/aC99BJKa+FOIyGJ6MVy29BFaw/TEKV9FK0T1sPDKygYrOkFpFLSslI4tqjwP5Rw
	98bs6wIRGYM5XWDQ==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] fs/procfs: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-21-bvanassche@acm.org>
References: <20241015190953.1266194-21-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910904622.1442.15883821629541971439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f4dd946c775e85e4f9aa460cd3dba197c35e43f1
Gitweb:        https://git.kernel.org/tip/f4dd946c775e85e4f9aa460cd3dba197c35e43f1
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:51 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:59 +02:00

fs/procfs: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-21-bvanassche@acm.org

---
 fs/proc/interrupts.c | 4 ++--
 fs/proc/stat.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7..714a22d 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -11,13 +11,13 @@
  */
 static void *int_seq_start(struct seq_file *f, loff_t *pos)
 {
-	return (*pos <= nr_irqs) ? pos : NULL;
+	return *pos <= irq_get_nr_irqs() ? pos : NULL;
 }
 
 static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
 {
 	(*pos)++;
-	if (*pos > nr_irqs)
+	if (*pos > irq_get_nr_irqs())
 		return NULL;
 	return pos;
 }
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index da60956..8b444e8 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -76,7 +76,7 @@ static void show_all_irqs(struct seq_file *p)
 		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
 		next = i + 1;
 	}
-	show_irq_gap(p, nr_irqs - next);
+	show_irq_gap(p, irq_get_nr_irqs() - next);
 }
 
 static int show_stat(struct seq_file *p, void *v)
@@ -196,7 +196,7 @@ static int stat_open(struct inode *inode, struct file *file)
 	unsigned int size = 1024 + 128 * num_online_cpus();
 
 	/* minimum size to display an interrupt count : 2 bytes */
-	size += 2 * nr_irqs;
+	size += 2 * irq_get_nr_irqs();
 	return single_open_size(file, show_stat, NULL, size);
 }
 

