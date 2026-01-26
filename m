Return-Path: <linux-tip-commits+bounces-8117-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHeFHD2Ld2m9hgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8117-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 16:41:49 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2198C8A41B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 16:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9ABEB3000B13
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 15:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6865340294;
	Mon, 26 Jan 2026 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K63t3DN+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GlZ3Q4b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027A38DF9;
	Mon, 26 Jan 2026 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442097; cv=none; b=P5NRJMcEtrRGoN2M1VHeV7SejeAuYiE5Xh4rt6e4aTN98tied3uuoQ5XkITvj52r2QWrw4/l8R4BpSp/Q0Fc6Py/k8q7W1raMalNoENjMcWwY+4tnhPBMlYtWMZz3VMH7+fbbDQrYgSZYwjFiJ/nSe91YCDR/nvPzRzsYAZ7348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442097; c=relaxed/simple;
	bh=PvWbkH7EhBuefTZ/tarAwPckhQiPsWXh0nNEIhErSrw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nlORUwe+ot8nYFcjtgfJNc5FPbZ4ycFAZ6bllN+xpCao+BxG3kXgRUJt1PsrvBxMf4/Jf0rQMQOZqxWLUcsoL8PM06Jxm4fdjMtQGISIIbu2dAhBC2emmvRpzD0dts2yQcrHpLN/phmRPQvKoZvTvV4GXQ8oah0/h7YVBYE8OAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K63t3DN+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3GlZ3Q4b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Jan 2026 15:41:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769442094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHRbp/5GuMBo3njapN5zJSM/T//ivdWPVUiCZ7Ds+Xc=;
	b=K63t3DN+CT6VdRnBH55skuxFDOu/5IV+/uvQ1Q6/k8IJBPi5bfqw+W9VwNssWzQz1+VZAh
	XNHVq+xmtSsS5+LI19vnFusqcakCbUoW9Os/Qfv7apsduNzJ2LhEED7KcaLN7ByDoZduo5
	WqnzZvfFUxCxPL4umaFIgu7TqQTMs4gEGIN4l4xusAkM2lqWFMep48p+3sd/0FbtN63+30
	VrUaE3Uy19Wq1a0ume5wUKPNzHUz/kau7tV97xZupd4r2MwNpJt/4UKvs6NfON8SOItTMr
	HnFfHoSLQgys6Ls1lSUvqUJ9WsYiPGV6gh2islSA7yUJsvkdlfW974CIUzYUcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769442094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHRbp/5GuMBo3njapN5zJSM/T//ivdWPVUiCZ7Ds+Xc=;
	b=3GlZ3Q4bJcmkm1kUrdLHlUfFLIjyT48LkMmzIJD7N6xOVKzfP1pyLPdXNn2aK7NQCLREYW
	YgdqkPwmvh6IUbCw==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Inline __x2apic_send_IPI_dest()
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223052026.4141498-1-edumazet@google.com>
References: <20251223052026.4141498-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176944209351.510.9002911212917109082.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8117-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 2198C8A41B
X-Rspamd-Action: no action

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     9bad74127f0ae8eeed2510fe381b064e08e6507e
Gitweb:        https://git.kernel.org/tip/9bad74127f0ae8eeed2510fe381b064e08e=
6507e
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Tue, 23 Dec 2025 05:20:26=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 26 Jan 2026 16:25:18 +01:00

x86/apic: Inline __x2apic_send_IPI_dest()

Avoid one call/ret in networking RPS/RFS fast path, with no space cost.

scripts/bloat-o-meter -t vmlinux.before vmlinux.after
add/remove: 0/2 grow/shrink: 2/0 up/down: 96/-97 (-1)
Function                                     old     new   delta
x2apic_send_IPI                              146     198     +52
__x2apic_send_IPI_mask                       326     370     +44
__pfx___x2apic_send_IPI_dest                  16       -     -16
__x2apic_send_IPI_dest                        81       -     -81
Total: Before=3D20861234, After=3D20861233, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223052026.4141498-1-edumazet@google.com
---
 arch/x86/kernel/apic/local.h       | 10 +++++++++-
 arch/x86/kernel/apic/x2apic_phys.c |  6 ------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index bdcf609..998efd4 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -14,7 +14,6 @@
 #include <asm/apic.h>
=20
 /* X2APIC */
-void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int de=
st);
 u32 x2apic_get_apic_id(u32 id);
=20
 void x2apic_send_IPI_all(int vector);
@@ -42,6 +41,15 @@ static inline unsigned int __prepare_ICR(unsigned int shor=
tcut, int vector,
 	return icr;
 }
=20
+#ifdef CONFIG_X86_X2APIC
+static inline void __x2apic_send_IPI_dest(unsigned int apicid, int vector, u=
nsigned int dest)
+{
+	unsigned long cfg =3D __prepare_ICR(0, vector, dest);
+
+	native_x2apic_icr_write(cfg, apicid);
+}
+#endif
+
 void default_init_apic_ldr(void);
=20
 void apic_mem_wait_icr_idle(void);
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic=
_phys.c
index 12d4c35..10f7902 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -107,12 +107,6 @@ void x2apic_send_IPI_self(int vector)
 	apic_write(APIC_SELF_IPI, vector);
 }
=20
-void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int de=
st)
-{
-	unsigned long cfg =3D __prepare_ICR(0, vector, dest);
-	native_x2apic_icr_write(cfg, apicid);
-}
-
 static int x2apic_phys_probe(void)
 {
 	if (!x2apic_mode)

