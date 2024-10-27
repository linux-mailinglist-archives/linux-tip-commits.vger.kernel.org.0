Return-Path: <linux-tip-commits+bounces-2614-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4CF9B1CF8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Oct 2024 10:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFD11C202F5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Oct 2024 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6681799B;
	Sun, 27 Oct 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bX6xB3uj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOPPPMnt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2942AD51;
	Sun, 27 Oct 2024 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022784; cv=none; b=EvI85Qq6VyWNmtvrQWPvUr38lNDNa1kzg1KM+EBoQAMVmcOwogQGCLrlWfMm5/2LYS7zeAJgOIqq1xBdv/Ezu/JWFsEdweX0ZLq8rxpMy8KSZopviCapk8nwLJXxPcRLFjlE9IjwJD7yK05XVzZgxB46Fiw4EIcijc9gGcOnMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022784; c=relaxed/simple;
	bh=PVd2b9X971H9wOAIUTeHGLFUo9jgiZxOjh6/Ar0HAS8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=URAt3mBtgcQZZo3TK0TASc7Yq8bVHWO3+VFL0kXl4BOArk+z2AcOyTELS7HVFkjoRCqu8cTCJCUk7LkbmUX3/+XezVLoq2ZWqjxtDIk3I5YzeTh4GPKPYMc4PH4sMNdKAR6vuRTOi78YhcZqYnK1u4+B30FO3YNGTSmWRapD7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bX6xB3uj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOPPPMnt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 27 Oct 2024 09:53:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730022781;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TCkHgVkQvoB7JgBdb0MQBVMrXRKjInn3DPtOG9KBLo=;
	b=bX6xB3uj1T77TK8U/E6gw+tEA28G7+GGsvuax6HIJgh/VB0DmqA415ANy6x3Kb+SMrmTni
	f8RGHb7m+Bk0NMER7vsQTXzgl2VMouItmcC8k2pwDLI866jRcTUyGO3+z1zQO5yJqxXhnK
	XzCRR7TpyIYLZ6QJ37YJkDTNP6aSwgvvn0EYcb4kTS3ztgUx1KEIZaxil090ISTvprO5dN
	LfRcEO7DESr3efl7EmKv2BTgtXffYkyHS4nKkK0ngWLhy8p90KK3+vPSiiGeCQkNfo0nG2
	nu/iNQd2lenYfqGqo4Vnh0o7W9vrOUR8oxVElG/6tTLeSS6/x8uUuXFewB2JAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730022781;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TCkHgVkQvoB7JgBdb0MQBVMrXRKjInn3DPtOG9KBLo=;
	b=yOPPPMnt+pzS+T5hNIA2Ld7nk2rHc8tgrqE0z4P/rE7EQsQFVe6Yhzz3NEaRc3/4DGeXEN
	BRaWTfz/zjL5tXAw==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdesc: Use str_enabled_disabled() helper in
 wakeup_show()
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241026154029.158977-2-thorsten.blum@linux.dev>
References: <20241026154029.158977-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173002278026.1442.15301826353081104665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d1a128bc3057a090b97ab5a9f938874df3d3f124
Gitweb:        https://git.kernel.org/tip/d1a128bc3057a090b97ab5a9f938874df3d3f124
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Sat, 26 Oct 2024 17:40:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 27 Oct 2024 10:42:09 +01:00

genirq/irqdesc: Use str_enabled_disabled() helper in wakeup_show()

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241026154029.158977-2-thorsten.blum@linux.dev

---
 kernel/irq/irqdesc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 479cf1c..0253e77 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -15,6 +15,7 @@
 #include <linux/maple_tree.h>
 #include <linux/irqdomain.h>
 #include <linux/sysfs.h>
+#include <linux/string_choices.h>
 
 #include "internals.h"
 
@@ -320,8 +321,7 @@ static ssize_t wakeup_show(struct kobject *kobj,
 	ssize_t ret = 0;
 
 	raw_spin_lock_irq(&desc->lock);
-	ret = sprintf(buf, "%s\n",
-		      irqd_is_wakeup_set(&desc->irq_data) ? "enabled" : "disabled");
+	ret = sprintf(buf, "%s\n", str_enabled_disabled(irqd_is_wakeup_set(&desc->irq_data)));
 	raw_spin_unlock_irq(&desc->lock);
 
 	return ret;

