Return-Path: <linux-tip-commits+bounces-7107-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB27C24AD6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 12:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 73F114E0F39
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD75342169;
	Fri, 31 Oct 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ILjlBkvz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+yOVSahM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14F332909;
	Fri, 31 Oct 2025 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908649; cv=none; b=sdhrOBNBjobYIiHu6Eg9UzFLbafEdvkb7R0G7TsIzegBwqM1hBSJ5BOa8A56LPhCPhZ4kXDM6F0vDx4yATwHxguQnglPOaujfX19uE133M1tMriPVaeHFZBzdPVT0zapUhaJNIQ4eq7T53r3h7D73dvmj1zrN9MtiZfvBwRuly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908649; c=relaxed/simple;
	bh=5/md+ArRGbXCxTf7vYNpPXqlG7jlhQz35hT8KIhg08c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mAeEBZyGZyJTF2K7UBZvGQwy2MyNentQb2HMLAfiXRTV9pgDTIpB3bYLpHNvlEH4yGriz2q+F6B4mvRnEmZIO5lruk0GjBSQdnBSdlVbIy038RbS52+1BdOWIpHtR0EsSm8qCNDSdWLPHtpzwzjaB0ha+LzeWRfG5zO37iZ203k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ILjlBkvz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+yOVSahM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 11:04:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761908645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTskQToT0TLQf2Env9XAbIAdx/FGCbYcmneukgzdSNw=;
	b=ILjlBkvzeYiPxLlYI02+eiCyyitzfSwOveYdj8QbwNhu6u9SenQV2LldbiQJHFuwy2RbvU
	d0tuLGecj9xHFeorHZOR/5p7A+UuqKnmah13iayK0QmBmov7G/2Ar+VcZMne8bEJPlxfSE
	Mf8i9mOxVohNqBdcC8XUKmLsb3jMEOxRz4s07J6SpuLKlPQyqTTBzIuIug2Kl0sUNdEat6
	JlXaPah6TcOKY/aJ4EkG8LIynEca6N5XGEQPf7sswG4Q9TuZNTLnn1bGD6mia6E04ghiYR
	+UcESaNejCSu2Yixm7OnAwRSkSzQRzch+5IHIaTozT4TRh/iXayz2OQC8JRROA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761908645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DTskQToT0TLQf2Env9XAbIAdx/FGCbYcmneukgzdSNw=;
	b=+yOVSahMm4kGoMtidABjxojp791tx2Ooj3izzP2t0KUq3yaiMxI7h8zSiMzR3MvWj5dbq/
	pdBN1AKmbfZCQrAw==
From: "tip-bot2 for Chen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove unneeded semicolon
Cc: Chen Ni <nichen@iscas.ac.cn>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020020916.1070369-1-nichen@iscas.ac.cn>
References: <20251020020916.1070369-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176190864463.2601451.9843790301993405883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5eccd322390e20ca2385f4a4b34ab60e7258ad48
Gitweb:        https://git.kernel.org/tip/5eccd322390e20ca2385f4a4b34ab60e725=
8ad48
Author:        Chen Ni <nichen@iscas.ac.cn>
AuthorDate:    Mon, 20 Oct 2025 10:09:16 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 30 Oct 2025 08:29:46 -07:00

objtool: Remove unneeded semicolon

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://patch.msgid.link/20251020020916.1070369-1-nichen@iscas.ac.cn
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5feeefc..3f20b25 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -451,7 +451,7 @@ static const char *demangle_name(struct symbol *sym)
 			str[i + 1] =3D '\0';
 			break;
 		}
-	};
+	}
=20
 	return str;
 }

