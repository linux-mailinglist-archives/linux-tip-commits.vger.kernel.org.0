Return-Path: <linux-tip-commits+bounces-1922-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6AD945F59
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 16:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD39FB22BD8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF220010D;
	Fri,  2 Aug 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tyvwg2Me";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iz50B8hg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558631EA0D4;
	Fri,  2 Aug 2024 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608756; cv=none; b=KYwJ54uep8zDB1QXTVh3Ex/jv5FQ/hHOHH6FeVQJiLL6HZ/iAUp58CMM3U7JZshNjAUrDpuz4jmn/YAiy0Uixw1ApOLwZpvPT1SGsucGb3Ja/2UZnjRTYkOm9maKK3RnhIj88/gqKhMwDAxejlIHskGlmsW/iw5TLhT5cDnLiTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608756; c=relaxed/simple;
	bh=Co3SfcPH86FqotqmqHqMY3nDy5IU7mXXAfmlYrhMsSw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VItF8fA7fHSf9AxlWQkm0r6R6MjC5roEzDWnsR/qqksrVHBqgieDY8Ae/g1oddsjvNRNvcwSiA9UjIBL1xu+L/18VnZ8VnzvHu1+AtFwlGD5bAB7Vd4IBlAwObkYI8FZewt6pVoQZ60I88ku4aPMe/Odms+OMzrOv6Y0RfKno9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tyvwg2Me; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iz50B8hg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 14:25:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722608752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbBrPx42mdqLqR2edi3MVdMGcAl3pLc9e38b4C0YBtk=;
	b=Tyvwg2MetSiT6MBXCh0tFGueKJ2Y5eztSuSc1RDwY6o1lwjHJ0xNjw49MTt0os9dVA85xd
	vS6DbBc2HWnDrmJodsp8YXfwgUocS/fnzmPrrn0u5VjHuwavtM9Ht5xnffQPNzJiq5+lQS
	zC95orH5XVLvYWsbLK5uty4Y1sb0ZMWaitIyLkI4hFFQwwOHWQ9j++qaehNlKSAK6TfD86
	PdmvKYGmb4Iov3yTrvhgVxSxiooPerkXRzvvi4rLKxpDtKTiv5xp2P/UDdPS7Dz/Zp0PTS
	PU03PLXuiNZrnXfjyXMKgyUX3sPMMeohnbBMoms7QfOTUnr9Pta0IUU/KE/hIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722608752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbBrPx42mdqLqR2edi3MVdMGcAl3pLc9e38b4C0YBtk=;
	b=Iz50B8hgqvn5OsUHRXroi8xrvyhczVJE09ENfxnxbUi0uxLxIUJMrWqOxGJGKvnmlJnVsX
	tjvLnjCzgdUkv+AQ==
From: "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Provide weak fallback for
 arch_cpuhp_init_parallel_bringup()
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240716-loongarch-hotplug-v3-2-af59b3bb35c8@flygoat.com>
References: <20240716-loongarch-hotplug-v3-2-af59b3bb35c8@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260875167.2215.5949239689343495190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     2dce993165088dbe728faa21547e3b74213b6732
Gitweb:        https://git.kernel.org/tip/2dce993165088dbe728faa21547e3b74213b6732
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Tue, 16 Jul 2024 22:14:59 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 16:13:46 +02:00

cpu/hotplug: Provide weak fallback for arch_cpuhp_init_parallel_bringup()

CONFIG_HOTPLUG_PARALLEL expects the architecture to implement
arch_cpuhp_init_parallel_bringup() to decide whether paralllel hotplug is
possible and to do the necessary architecture specific initialization.

There are architectures which can enable it unconditionally and do not
require architecture specific initialization.

Provide a weak fallback for arch_cpuhp_init_parallel_bringup() so that
such architectures are not forced to implement empty stub functions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240716-loongarch-hotplug-v3-2-af59b3bb35c8@flygoat.com
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c89e0e9..1632361 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1829,6 +1829,11 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
 }
 #endif
 
+bool __weak arch_cpuhp_init_parallel_bringup(void)
+{
+	return true;
+}
+
 /*
  * On architectures which have enabled parallel bringup this invokes all BP
  * prepare states for each of the to be onlined APs first. The last state

