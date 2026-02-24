Return-Path: <linux-tip-commits+bounces-8237-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DtNC3JSnWk2OgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8237-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:25:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2F2183001
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B4D3157F3A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 07:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5813644B6;
	Tue, 24 Feb 2026 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nEZJSUOf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RsyRbRoE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6B36405D;
	Tue, 24 Feb 2026 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917633; cv=none; b=Q/3IC+7EoBZsjGYSTejumd38sP20Gvo0MXw+S/qjtTIFfdwWypsEa2leEY7Auw+y7moPLnCbTnvOUy1Uu68zyiOTyd0S7dxTV6MtxVYqRXuK63cYtMn9SE9eaLz0QhHhepTqDol+KkWVy73laiiw4veOvJpY9nc5ZsbTH/vtQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917633; c=relaxed/simple;
	bh=U8cl0UrFuGxGqO/hGsxf2+twnT6vh1i/aqTAPnVNCpM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jGkA8eNVvmKHRfJUeeggVQa3qO6jzzVGtv+RjKRQVx7o6s/x0oSABTScN1agJv/o5Ny9MwBIdoNBFhpWci/XwCtwMBZGYFmU3eTFmQMQR4efLjx/5BRIHK9xxL8e4y3Id2RF2myBCj4Okk2LwiCHhccfzRVvfOANVyKSFIofQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nEZJSUOf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RsyRbRoE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 07:20:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771917624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7W4tjN35n2H+nN6EShfJw6KhYRBQMWncJ02gRNVlbs=;
	b=nEZJSUOfYsLbsJ4+1DFrQzlwQ9iXSiSf1WjY5+qLRODdpqu1gOSX9Pkk4vEMKidiIjXESG
	S5QJtgM8qqPs6hAbZCsT7HLy+2A/mB5iJh6F9P6XI/ImrnJc5MAft9XC78eyXsRdrduzBO
	il/vZ5V+JllPOfERmXKNWtQwJJz+uxToJkRHNU/lt4+2MSHJNm00s5i8ZaYgVwyhctKxNV
	f3DSdQQ7H+Eomp1d03WSRjPlNGbYu/K9/jCuxNVUf0xVpkGlqtI/fcTMQlSSALhCR9AgdC
	TALDu+xOB6r2y88y0SIPGMpvW0ycJsL4GHYFAvhA8D83JbZ41V//6ZQ8XVVo6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771917624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7W4tjN35n2H+nN6EShfJw6KhYRBQMWncJ02gRNVlbs=;
	b=RsyRbRoE6YhENCzk5JacbiW8ZiuACTVNEtYCl7+CABTAbgwS6A1lGs9Tpr8CnmRB5pvaix
	LZIQfcW3L1EcUtCw==
From: "tip-bot2 for Brian Masney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-pic32-evic: Only include asm headers
 when compiling for MIPS
Cc: Brian Masney <bmasney@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260222-irqchip-pic32-v1-4-37f50d1f14af@redhat.com>
References: <20260222-irqchip-pic32-v1-4-37f50d1f14af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177191762356.1647592.7451277104739316403.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8237-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 7C2F2183001
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     6096f427ed8efff6198f2330f1756f9381c8a8ec
Gitweb:        https://git.kernel.org/tip/6096f427ed8efff6198f2330f1756f9381c=
8a8ec
Author:        Brian Masney <bmasney@redhat.com>
AuthorDate:    Sun, 22 Feb 2026 18:43:47 -05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 08:15:43 +01:00

irqchip/irq-pic32-evic: Only include asm headers when compiling for MIPS

The asm headers are not actually needed when compiling on architectures
other than MIPS, and traps.h is not available on all architectures.

Include them on MIPS systems so that this driver can be compiled on other
architectures.

[ tglx: Massaged change log ]

Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260222-irqchip-pic32-v1-4-37f50d1f14af@redha=
t.com
---
 drivers/irqchip/irq-pic32-evic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evi=
c.c
index afb7002..ecea7cb 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -15,8 +15,10 @@
 #include <linux/irq.h>
 #include <linux/platform_data/pic32.h>
=20
+#ifdef CONFIG_MIPS
 #include <asm/irq.h>
 #include <asm/traps.h>
+#endif
=20
 #define REG_INTCON	0x0000
 #define REG_INTSTAT	0x0020

