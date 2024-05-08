Return-Path: <linux-tip-commits+bounces-1244-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DFF8BF6FE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 May 2024 09:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461581F23F12
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 May 2024 07:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFDE34CDE;
	Wed,  8 May 2024 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2G2BJzK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QgNPB/2h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8842BB1E;
	Wed,  8 May 2024 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153234; cv=none; b=FfgvT+Kr4J4OC6eheiPxhMGd8qA12uCr+xWDdbWjZetwnoiUiRE2JTyOSqt+YalNOzPb+sSCxMkI9jPfoBL0XO6EAP5PEJr/CvCWeNBFcY2mjKssKgwuW4Ma/VDvc2KeYUePmnIuUWvASwFTp93o5PqKMfNEkg9zMGY+t96xy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153234; c=relaxed/simple;
	bh=/BCtZ9w0BUivyHfHK3nkVeD/Eld4qtRuqJFrYgSpw10=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rSUWfYmrOXFpPXHgSc+Vd7fuiSHbeTiy0C3Rbc2ga2a0864J/pajnAClJHjexgYbH8RxvDluasjswq3EY1D5vQtOrdxxDe6ZockoHJ7LTXtKi9NhxNd3DVsTVnXEkc3dOb2k1YvmXew0J57EJIP5bYjinbylTe2e9bT8TRP5dnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2G2BJzK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QgNPB/2h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 08 May 2024 07:27:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715153226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cfe0bRArhgSnwFFTSmK8hkA8vGKBx7Rip5BRe3tmYc=;
	b=e2G2BJzKbXpEL3JY0560wyPQQFjmVF/QZL8LHmYVhCbb70f9slIhCLlxM2FsSh9HAPxbP1
	qAW+vJ4ZoBKzyx5Nmcws49FyBf47gwS3a6xvn61Vq4CEjvxFYj95XQ+GZxW2jnYPVLkB7O
	Q9U0gx9mjnkszjf1RBnoFGaybgq17u75fkIBqQEIwF7qIVjaP9haOsMhRgBERmjlS3tLMm
	ytzi5Zupsvp11NB+b+10JdrqHucdbf7oCFMnk8W7XTn58m/pNm7RpjtaAYxW8HBbBAwGvh
	INQm0TeNjB3UV7mckpC2POPCkxVVIKaU0mgb8b8dzFWlkfS33rcb5cnF6yd6EA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715153226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cfe0bRArhgSnwFFTSmK8hkA8vGKBx7Rip5BRe3tmYc=;
	b=QgNPB/2huNGf1Bx4k1nG80vpYbJiMwSXZ692ji+ffK6FCwJ1Klieg7B1xm0NJG6cYjFZHm
	+PBFHIUM4Kh38BCw==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/pci/ce4100: Remove unused 'struct sim_reg_op'
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240507232348.46677-1-linux@treblig.org>
References: <20240507232348.46677-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171515322582.10875.10439835550182173847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ad3bd7659b68add28920982e02233b5dc4b483c3
Gitweb:        https://git.kernel.org/tip/ad3bd7659b68add28920982e02233b5dc4b483c3
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Wed, 08 May 2024 00:23:48 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 May 2024 09:17:17 +02:00

x86/pci/ce4100: Remove unused 'struct sim_reg_op'

'struct sim_reg_op' wasn't ever used since it was introduced
14 years ago via:

  91d8037f563e ("ce4100: Add PCI register emulation for CE4100")

Remove it.

[ mingo: Improved the changelog. ]

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240507232348.46677-1-linux@treblig.org
---
 arch/x86/pci/ce4100.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/pci/ce4100.c b/arch/x86/pci/ce4100.c
index 8731370..f5dbd25 100644
--- a/arch/x86/pci/ce4100.c
+++ b/arch/x86/pci/ce4100.c
@@ -35,12 +35,6 @@ struct sim_dev_reg {
 	struct sim_reg sim_reg;
 };
 
-struct sim_reg_op {
-	void (*init)(struct sim_dev_reg *reg);
-	void (*read)(struct sim_dev_reg *reg, u32 value);
-	void (*write)(struct sim_dev_reg *reg, u32 value);
-};
-
 #define MB (1024 * 1024)
 #define KB (1024)
 #define SIZE_TO_MASK(size) (~(size - 1))

