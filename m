Return-Path: <linux-tip-commits+bounces-8360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF3IBAOnqWnwBgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 16:53:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70801214E60
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Mar 2026 16:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A4DC3139A77
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Mar 2026 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5C3C1988;
	Thu,  5 Mar 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TTm9TBs7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4tWZLcn7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC43CB2F1;
	Thu,  5 Mar 2026 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725381; cv=none; b=A5S/boCh5uM5YreBPp6zKHfGqYO3nbz9Ug9tavX2b3fd9dcwScVUsBn8wxPugBhDy05/S5pNmw1l0LxlkI3VPuOyCHnMJqY9B85mxZHiAwSs8XZG/OOLtsf+VrDGw/aelY/Itn/wdPmxehPTFVVx8gDZCo17sp3LR0y8WTM24M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725381; c=relaxed/simple;
	bh=uAyaE7YwZi65cQ1Wn8uL0t2BNbiDLm8eECh+0sRJy70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kqOZ5AqlKI/0DF/qNrrFKzyRKEprP3uxEDXc9XIciXtd2+Wz9ZUor4qC5EMrTNo2btZ3ZaJXt57WnggLK/LxmmGq7KvLFBB5GNpRylQiwd0ata0e9MPxM7OFPJ5eQK7yGTAeCAbL2MvjM3dfMsBN9GNGTQMfJVyOus78iazOt9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TTm9TBs7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4tWZLcn7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Mar 2026 15:42:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772725378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0888yEXiLD0GhvLVpzBbDHmQAz0yRCo2Sin7y8WDjE=;
	b=TTm9TBs7+IPs8oVZwuEOxhrX19YRM8OpF1iY6Kx9+TuOS9oXcqFPX6jBT0z+Jr36f6ckYw
	uz4Yjb6GrFEGk/eB9eUoPtHpVGXAaRKi/umhCsvA1drDpj/jIp4v8+yzKWQzpBxrgNvOX9
	sdNZZljtUtYM0QEjbuUV8KuyNJ4TIkAH5HMR298t+yPWZw2Et4K36WhW3DWKA3c6+oh0v2
	ffJkoon5PofMBeWG9CdOWD4nyNJxnKJ8SP2EYoK2clpl6i5qiEIv+1Jv9La9GZLR4x/lwQ
	PsSms5gfosaSAnFDBvEFrY59bVFbFyZYy4zmc4SZRQ0yEjvCW9spbqWeFJGyzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772725378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H0888yEXiLD0GhvLVpzBbDHmQAz0yRCo2Sin7y8WDjE=;
	b=4tWZLcn78IhDEUZp77FDUWjfIBX2hSz4GCA8lAQ3xa5aXKK0a5hrmfmF4yNAGpFvmvVPPO
	Apklp5DC4jzql4CA==
From: "tip-bot2 for Martin Schiller" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/reboot: Execute the kernel restart handler upon
 machine restart
Cc: Martin Schiller <ms@dev.tdt.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260225-x86_do_kernel_restart-v2-1-81396cf3d44c@dev.tdt.de>
References: <20260225-x86_do_kernel_restart-v2-1-81396cf3d44c@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177272537654.1647592.10340742617382209452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 70801214E60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8360-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     ae715818c5d7e486fe97806a734205cea63921e2
Gitweb:        https://git.kernel.org/tip/ae715818c5d7e486fe97806a734205cea63=
921e2
Author:        Martin Schiller <ms@dev.tdt.de>
AuthorDate:    Wed, 25 Feb 2026 08:46:09 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 05 Mar 2026 16:22:43 +01:00

x86/reboot: Execute the kernel restart handler upon machine restart

SoC devices like the Intel / MaxLinear Lightning Mountain must be reset by the
Reset Control Unit (RCU) instead of using  "normal" x86 mechanisms like ACPI,
BIOS, KBD, etc.

Therefore, the RCU driver (reset-intel-gw) registers a restart handler which
triggers the global reset signal.

Unfortunately, this is of no use as long as the restart chain is not processed
during reboot on x86 systems.

That's why do_kernel_restart() must be called when a reboot is performed. This
has long been common practice for other architectures.

  [ bp: Massage commit message. ]

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260225-x86_do_kernel_restart-v2-1-81396cf3d4=
4c@dev.tdt.de
---
 arch/x86/kernel/reboot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6032fa9..ddff25a 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -773,12 +773,15 @@ static void __machine_emergency_restart(int emergency)
 	machine_ops.emergency_restart();
 }
=20
-static void native_machine_restart(char *__unused)
+static void native_machine_restart(char *command)
 {
 	pr_notice("machine restart\n");
=20
 	if (!reboot_force)
 		machine_shutdown();
+
+	do_kernel_restart(command);
+
 	__machine_emergency_restart(0);
 }
=20

