Return-Path: <linux-tip-commits+bounces-8342-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFk4M6x2p2nyhgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8342-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:02:52 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F391F89F2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F4483155357
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Mar 2026 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7E6377EAC;
	Tue,  3 Mar 2026 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mA6q3Hq0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WFXNDvR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E59374E71;
	Tue,  3 Mar 2026 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582361; cv=none; b=YSP7K8qT0g7kjfdm+2UP6WCx1pdfScd0zQj6V3ui32b979zRJ7htnzWrIpuTB7HvvhJBWclqehCkeIkXP8Wko/+jHdhntXHrPHuqheb5zfQrP5mJc7A3HTWs8je/bDEgkMJahu2ikancnsJz4nV865oR6VYKQU2h4Yh2LZ+fDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582361; c=relaxed/simple;
	bh=toZ7S88XMEjC8NPxeHVoJo35s2tl0+7VV3fLAQfPT/8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jCL6fHM3bjPQYgcoxBTuZdrlBXVWJIlwTK/Pg4DYGDMgdf/gfyfpOT1fdl7qeRqGCKnBhLq91EtF7Ks0hyC1UnxZCPN02AisRqBE3fzPUSANereOdC0p+6mmzPbqipPJ3SNPeeJFRQxQFgFAPo2NR5uQoPeL+pVaS/B+uWJIdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mA6q3Hq0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WFXNDvR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Mar 2026 23:59:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772582355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9PPkUvRdZD4n0k9QpNMGhXyiOmnQ6qhzRpgbP9ZJfQ=;
	b=mA6q3Hq0apWmgVrU+nx+ts9Tr94hquSeiG8wNRhwJLMm8KOWLxVd3W98dvUEo0Na0fUiBb
	CJWxuXr9oXHqQ5IJ4xuKjHIj70rVBuwntR9nZwilphuHmIgm083P8nBv11boEHXU6Al+RH
	XzdgTxjAIv9isd7keWMzGPbdJbMPzq7VdMflAWx+1qawY8sImVy1EsFaVfoOL38lfoAc4B
	DZokfoJUmt68OPvEuMcBlqEDAxM7zIQ1LN5uq4FqSZ3F5EYtN5fVMQCa37oryCfRjH5Y4S
	4PhiyjFmai8ooOKIN5VMwTLwPhlX7gCUBJNKFs71yNL3e/Jzq1O8gLEokD6L1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772582355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9PPkUvRdZD4n0k9QpNMGhXyiOmnQ6qhzRpgbP9ZJfQ=;
	b=0WFXNDvRzdq0qZGK0lo+DyIfQTW6HxVeu4HSgDN9zuyQNIGXqeC8B8QyKfuoif0KMJ+HyI
	+7zvnDhtkTtiQtDg==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove LASS restriction on EFI
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
 "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260120234730.2215498-4-sohil.mehta@intel.com>
References: <20260120234730.2215498-4-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177258235440.1647592.17897502271877489630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 39F391F89F2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8342-lists,linux-tip-commits=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     68400c1aaf02636a97c45ba198110b66feb270a9
Gitweb:        https://git.kernel.org/tip/68400c1aaf02636a97c45ba198110b66feb=
270a9
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 20 Jan 2026 15:47:30 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 03 Mar 2026 09:49:45 -08:00

x86/cpu: Remove LASS restriction on EFI

The initial LASS enabling has been deferred to much later during boot,
and EFI runtime services now run with LASS temporarily disabled. This
removes LASS from the path of all EFI services.

Remove the LASS restriction on EFI config, as the two can now coexist.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Link: https://patch.msgid.link/20260120234730.2215498-4-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/common.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8c56d59..3557f0e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -415,14 +415,9 @@ static __always_inline void setup_lass(struct cpuinfo_x8=
6 *c)
 	 * Legacy vsyscall page access causes a #GP when LASS is active.
 	 * Disable LASS because the #GP handler doesn't support vsyscall
 	 * emulation.
-	 *
-	 * Also disable LASS when running under EFI, as some runtime and
-	 * boot services rely on 1:1 mappings in the lower half.
 	 */
-	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION) ||
-	    IS_ENABLED(CONFIG_EFI)) {
+	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION))
 		setup_clear_cpu_cap(X86_FEATURE_LASS);
-	}
 }
=20
 static int enable_lass(unsigned int cpu)

