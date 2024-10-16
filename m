Return-Path: <linux-tip-commits+bounces-2487-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076059A1356
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3D12836EA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2B021BB1E;
	Wed, 16 Oct 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiQcfud/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gUkiWW0C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5FB21BB02;
	Wed, 16 Oct 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109070; cv=none; b=LfIDqsEKzD7scNudXj8VWTJE7pwxahYjtzA/R5+8VBujFB1OAw2/U2VoYTKmdp+aBw1+T6wzvgsTenw2EsZwbtQfJkEmAwagShQs/DeIG6kbYt27AdBNj+JxEpBRtwTrIIGbhbxz601QGCcplX2X9dIteTCr2OaqslBbEM4PMkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109070; c=relaxed/simple;
	bh=7A/zQav65kWKJ6r0LnHwg5ffIWfbxJALphkPDtdlrzw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DO9E75SqWENP9KBPCquplcwi/pHKD3FYqVkWpwmOEXypjpWkRBS0qEG3+eNpr4xtFgXa8FcBospOl4hKY1w4snyVwmh05TBHImHHAG86YXKhQI6q25AY1fj8wDlWJgum+cJuXcGC5rp+PUtn4ywcDWUzZQ4+htrjvBhGaPWpsWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiQcfud/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gUkiWW0C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWw0J+DlccFWLgvZhQ9pf0oOiAlRWiijnEeSqh+9BGo=;
	b=fiQcfud/1ZY4nAFIx6dxyhKW8FiI5QdJvBzhnMleCpHesGbqjIMaBd2+sgqZa9OEOGv0/B
	EQy4kp1zIhF040Gc6Y6C1kdlwcx/SML1Surb7onQl2dbPjVn0rmrJX0/WyxXE8xDluqRKp
	9zK1YN974E4AKptizsN0PdtrTjiAYbIAbvjecyDTl7xNnGOFa/YCh+TOg7j0kRM9hfE13+
	Mn+dCaDWWUfTvttwVsBJ2wRRFqMtpxCmxArXCUouy8UHA/rieqrRK8Jow/8yzjRExeSdjY
	cJAovrnjhpKHP8235xsiCz4ZCLr3Aw90QNUbbIDrrWw7UzvqtEqwNq1mWbIaMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SWw0J+DlccFWLgvZhQ9pf0oOiAlRWiijnEeSqh+9BGo=;
	b=gUkiWW0CqBkdYXRdz7mY+PFAeH5bPD6d0MZ3S8nHysbpl/KRFhwCoqBqqGcf8u4fGROhd5
	rIkmHOGZOHqjHLBA==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] s390/irq: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-6-bvanassche@acm.org>
References: <20241015190953.1266194-6-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906537.1442.6017383655600342438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     951248383a9029f236e80c3e408012f6e280fb2f
Gitweb:        https://git.kernel.org/tip/951248383a9029f236e80c3e408012f6e280fb2f
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:36 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:57 +02:00

s390/irq: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-6-bvanassche@acm.org

---
 arch/s390/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 2639a3d..a2c8671 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -253,7 +253,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 		goto out;
 	}
-	if (index < nr_irqs) {
+	if (index < irq_get_nr_irqs()) {
 		show_msi_interrupt(p, index);
 		goto out;
 	}

