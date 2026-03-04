Return-Path: <linux-tip-commits+bounces-8349-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLn8AvwSqGnUngAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8349-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 12:09:48 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC71FEB4A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 12:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69EDD300361D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Mar 2026 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5B39183B;
	Wed,  4 Mar 2026 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SfzEAiGs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8gwgQ2gi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5981C84AB;
	Wed,  4 Mar 2026 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622400; cv=none; b=SgERWr7vOzEFaU5NoctBRq4oChHrmXLKFp3U3z6+80WZ0hpjdRqdIhms7fWWR5jv1S6eC9vX7wQk5FsKyk9CmZ2JSQkJzBWSVVv8Wl940/y4aum4a6wUyO0oBnGynd5P39yEWP+oMToDrWvRd2VqlrrkZq1Z1pudTcWR145b5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622400; c=relaxed/simple;
	bh=0S+UMGxyz/VlKVZVgjN5kTVRLcWWhAVvzNlN+bUHd1A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aTt5Hme7ACgOlCGbn6M9WcJm1BRA81pgKDgHdDLdagn93lN19HnO3aV5ON24pWnzo9fNohgcAUlU+i5veOrX8p1iwgpHlkeAC7SAOaFxW9Ol9cYqVN346xzjeaPDXHo0e2gPZjrLrNEvs4uWHOilkE0f3eiG/g2bhMpnUpGZ5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SfzEAiGs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8gwgQ2gi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Mar 2026 11:06:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772622397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcBNp2ovyv7Yd17kmfW2QFE6hiu/So+zMuKSdoHNeEc=;
	b=SfzEAiGsME45W7q+A1bd3DvuylJJSplNXlE5w1IW8O2dZiBZk+m1SmaECe5QPCcXEa5ahQ
	TpB3HiggeeNRmC1Kc9N7MdoDQybdfh0OCwq7KjpXf7yuhnxRhyvWD/NOjbI4nIS3iRZhDb
	hjvTSUp3ZTgZMPjNmiEp8pQEoEMr7Nz8AW3LpahTz6DV9w9SGLbzyR2rh7UKUFwBcq6OGO
	/vsJzyQBr3AtchiFdcXQZA9qHPUDdGwsEI6psVO63OnOTOydMdlVA3VnuzAwsuJNqZxjaM
	6ngS0KlSA9vUkb5VLtdI5KAlmTF6qU+wtUGhYMd30dkpcqQLcsqdI6FMycQXRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772622397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcBNp2ovyv7Yd17kmfW2QFE6hiu/So+zMuKSdoHNeEc=;
	b=8gwgQ2gi9pw2hTv5SfzWkj3uuNLmoxy+S1iQKglT6Jf0AodfsFzf/KID8IXeEyJy0ZCqcc
	UAdDNku9FOd0u0Cw==
From: "tip-bot2 for Jan Stancek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/boot: Handle relative CONFIG_EFI_SBAT_FILE file paths
Cc: Jan Stancek <jstancek@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <f4eda155b0cef91d4d316b4e92f5771cb0aa7187.1772047658.git.jstancek@redhat.com>
References:
 <f4eda155b0cef91d4d316b4e92f5771cb0aa7187.1772047658.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177262239619.1647592.10382021667894669746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5DAC71FEB4A
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
	TAGGED_FROM(0.00)[bounces-8349-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alien8.de:email]
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3d1973a0c76a78a4728cff13648a188ed486cf44
Gitweb:        https://git.kernel.org/tip/3d1973a0c76a78a4728cff13648a188ed48=
6cf44
Author:        Jan Stancek <jstancek@redhat.com>
AuthorDate:    Wed, 25 Feb 2026 20:30:23 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 04 Mar 2026 11:51:08 +01:00

x86/boot: Handle relative CONFIG_EFI_SBAT_FILE file paths

CONFIG_EFI_SBAT_FILE can be a relative path. When compiling using a different
output directory (O=3D) the build currently fails because it can't find the
filename set in CONFIG_EFI_SBAT_FILE:

  arch/x86/boot/compressed/sbat.S: Assembler messages:
  arch/x86/boot/compressed/sbat.S:6: Error: file not found: kernel.sbat

Add $(srctree) as include dir for sbat.o.

  [ bp: Massage commit message. ]

Fixes: 61b57d35396a ("x86/efi: Implement support for embedding SBAT data for =
x86")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/f4eda155b0cef91d4d316b4e92f5771cb0aa7187.17720=
47658.git.jstancek@redhat.com
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Mak=
efile
index 68f9d7a..b8b2b7b 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -113,6 +113,7 @@ vmlinux-objs-$(CONFIG_EFI_SBAT) +=3D $(obj)/sbat.o
=20
 ifdef CONFIG_EFI_SBAT
 $(obj)/sbat.o: $(CONFIG_EFI_SBAT_FILE)
+AFLAGS_sbat.o +=3D -I $(srctree)
 endif
=20
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE

