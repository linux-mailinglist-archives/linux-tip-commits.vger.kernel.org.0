Return-Path: <linux-tip-commits+bounces-2966-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABA69E1EBB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 15:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8AF162C9F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C381F4267;
	Tue,  3 Dec 2024 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HOSeR7jC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAa7yC0q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEE81CF8B;
	Tue,  3 Dec 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235092; cv=none; b=VVvGUFjo8XXo5mkwk1slo8cvUo8CymCxYqtEmvpxsFM8UT6OEkzOiHrFliuzyPdcVjum5ecEGRLOKxhUrjrMMWxJEMEZ9MsqdAA2suiGphvN/VgvPM8B9xJuUlJBBYBrUJ/d4pbGsJdBONuzlCyLcMRwkDXDi2FB0nTSPLsDTQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235092; c=relaxed/simple;
	bh=+tM69df6UDqQetalnmXh4UrchFpXRGsRL7t5CwF+5JE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tbeLIB2LxAZbdd0cGwE6q40EbNyWZFQsJxtKsgtcWlslKSUfFoQbzq0tYSsWsbCFN4aXWdFAMlZ3rulIIabhTKq2paNZaz4pK3ok+lj+38Ks4XiB/rK9TYc+vOJYL/n7J9N5dugBYMJGMamNGIxB0awEAjz3wd5HnaUyFBJTf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HOSeR7jC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VAa7yC0q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 14:11:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733235087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myItliXk/eIJTLq80hjrXXhPz2Noo54UPGATf/c/cOY=;
	b=HOSeR7jC9wt/2oNDhC//pSX+0/C/Ubh/XCXuDm/y0UTU33ZGGAiPG+z1LnzGLd4fXokMxq
	spBapT/Z3P+I4z+o5pgDTZpdXiDMp7S8iMyPfT27HG+a5TXyhfrYSlau2nzawHpdIhqg3X
	+2H74dtaxlK9wN7yPLbuiwHYMXIoyMkyDH57Rc5tYBk/2WDsjpSFvoLwtJtNs/b3Jwygki
	UtTATlL9PHNZlZmjLINZrpyPhdQ7rBML5om2EiDKxVMotYaD1vQWHxvUuGkgSYZcLKoKF7
	dJ+cNUKXmo2zmEDnVJDcy2vG0cdXk8uI/P9nhEP69c+J9W/iZ94fpTzXyqXw/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733235087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myItliXk/eIJTLq80hjrXXhPz2Noo54UPGATf/c/cOY=;
	b=VAa7yC0q8DFluDISb6yjEvA4fkr+9707Z4YrR0zLTcMfqpkhnwtElGiEeggQ3d5+s+EjzB
	6OHvM+cvd55LMFDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/proc: Add missing space separator back
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Wang <00107082@163.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87zfldt5g4.ffs@tglx>
References: <87zfldt5g4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173323508673.412.13371248163966680303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9d9f204bdf7243bfc2c6a023d63c63f7cbf8ef0b
Gitweb:        https://git.kernel.org/tip/9d9f204bdf7243bfc2c6a023d63c63f7cbf8ef0b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 03 Dec 2024 11:40:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Dec 2024 14:59:34 +01:00

genirq/proc: Add missing space separator back

The recent conversion of show_interrupts() to seq_put_decimal_ull_width()
caused a formatting regression as it drops a previosuly existing space
separator.

Add it back by unconditionally inserting a space after the interrupt
counts and removing the extra leading space from the chip name prints.

Fixes: f9ed1f7c2e26 ("genirq/proc: Use seq_put_decimal_ull_width() for decimal values")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: David Wang <00107082@163.com>
Link: https://lore.kernel.org/all/87zfldt5g4.ffs@tglx
Closes: https://lore.kernel.org/all/4ce18851-6e9f-bbe-8319-cc5e69fb45c@linux-m68k.org
---
 kernel/irq/proc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index f36c33b..8e29809 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -501,17 +501,18 @@ int show_interrupts(struct seq_file *p, void *v)
 
 		seq_put_decimal_ull_width(p, " ", cnt, 10);
 	}
+	seq_putc(p, ' ');
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
 		if (desc->irq_data.chip->irq_print_chip)
 			desc->irq_data.chip->irq_print_chip(&desc->irq_data, p);
 		else if (desc->irq_data.chip->name)
-			seq_printf(p, " %8s", desc->irq_data.chip->name);
+			seq_printf(p, "%8s", desc->irq_data.chip->name);
 		else
-			seq_printf(p, " %8s", "-");
+			seq_printf(p, "%8s", "-");
 	} else {
-		seq_printf(p, " %8s", "None");
+		seq_printf(p, "%8s", "None");
 	}
 	if (desc->irq_data.domain)
 		seq_printf(p, " %*lu", prec, desc->irq_data.hwirq);

