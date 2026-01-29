Return-Path: <linux-tip-commits+bounces-8140-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMFTJezRe2m0IgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8140-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:32:28 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A117B4C52
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 548533008C14
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 21:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A6C35DCEC;
	Thu, 29 Jan 2026 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JdgE1k/p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vIxsHLb7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135535CBC6;
	Thu, 29 Jan 2026 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722333; cv=none; b=k8rqJH4C2/eo9BzS52bGCFYbfOOWVQEfunQgzDoHA81+QNwFBAsBuPeX7zAzm0V0VozKAyk/QrcN4gvcVmB4hrn/jNCI+fUydIlZj2xcomlM0FI9gFFrnyUbPwgMhAAGTH9+q5iwQLlsOkVTiMSXY+LNlmk9XrXwQ1Qi5F7SooE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722333; c=relaxed/simple;
	bh=pmFyNnoEy0w7zruHxPGHGcNOqgxQIFMgewlkxVNCQqY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AXhdmdvCNjYGRbNZKjJ4Jd3Wq4cuz7pemJPisvByC1DVNOILy20dDZCsvVjGw94MOW0lIFFVLMluh8wQ4+poedyLY7GBtTTNr2yxHs0TyPEA5AhKv21cMLD4h+h5cIWDCFB8cj3eg6i9uC2w6XGceJSO/FgCCD6+kFXdvjDtr7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JdgE1k/p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vIxsHLb7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 21:32:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769722330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An7aFd7VWQd8nTrZpCKNv1ma3QmeQObI4qAFOQqCSuk=;
	b=JdgE1k/pMlmWxFqKHroqU4lG46vVxHKDGkDJahmrihmGqyMaaRBkLNMOHuHYcoS7eAz2kG
	E5BheD3/fEdXnD7EAo5NphqbPs0P4paHvWzxFAaq+ilILq+DotTGn1KC270xaai/DycHaC
	4f1kL5/aGgaEcvkwuGRQRZm/mdUqCb/5kpPjMFmXUgSk4DF02a3P8ca/95TvdFYtzwT7KE
	9UXa0ZQ4vaBEtMNpMhS3H5KN8kpc/t9rnq7hH9vpkrztoc/589TyqKRaP1sviFiejmqeZq
	FO+Jy75p/7A5osTkX1LE8F9CfJSX6PqmzrsZVNgLX31NrGP6VDBvIY4/VBKfVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769722330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=An7aFd7VWQd8nTrZpCKNv1ma3QmeQObI4qAFOQqCSuk=;
	b=vIxsHLb7LeN59xo2EVh6zXNqJva4yUrYpo2sobzb1pPOUkgtIlbL7cRG3vt6z9YCRD5I9a
	VVmf0KPVzk5SEYAA==
From: "tip-bot2 for Soham Metha" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/armada-370-xp: Fix dead
 link to timer binding
Cc: Soham Metha <sohammetha01@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251203195859.65835-1-sohammetha01@gmail.com>
References: <20251203195859.65835-1-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176972232891.2495410.2595329926883521387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8140-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 3A117B4C52
X-Rspamd-Action: no action

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     f555fd9ebec9aefaa6281b457de27dd6cba1d168
Gitweb:        https://git.kernel.org/tip/f555fd9ebec9aefaa6281b457de27dd6cba=
1d168
Author:        Soham Metha <sohammetha01@gmail.com>
AuthorDate:    Thu, 04 Dec 2025 01:28:59 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Jan 2026 18:06:45 +01:00

clocksource/drivers/armada-370-xp: Fix dead link to timer binding

The old text binding 'marvell,armada-370-xp-timer.txt' was replaced by a
DT schema in commit '4334d83904fc'
("dt-bindings: timer: Convert marvell,armada-370-timer to DT schema").

Signed-off-by: Soham Metha <sohammetha01@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251203195859.65835-1-sohammetha01@gmail.com
---
 drivers/clocksource/timer-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-armada-370-xp.c b/drivers/clocksource/=
timer-armada-370-xp.c
index f2b4cc4..a405a08 100644
--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -22,7 +22,7 @@
  *     doing otherwise leads to using a clocksource whose frequency varies
  *     when doing cpufreq frequency changes.
  *
- * See Documentation/devicetree/bindings/timer/marvell,armada-370-xp-timer.t=
xt
+ * See Documentation/devicetree/bindings/timer/marvell,armada-370-timer.yaml
  */
=20
 #include <linux/init.h>

