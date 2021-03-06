Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7B32F964
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 11:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhCFKie (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 05:38:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhCFKiW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 05:38:22 -0500
Date:   Sat, 06 Mar 2021 10:38:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615027100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSSfOnWXoj1UNYlFixyPMLY4tAQO/UE7XPtf2ZoG8ko=;
        b=KD+jVaIDh6UY+bU64o9RG3rpBd52ZTW5CuksOvXMAG0Lhp4+3Va8NKdbGJTFYGYYP4o48W
        WJEl5jELL+7AUA1hIaWhb7yEQu0hoRUFOGMY6C312wnccNMQpzcUhQlJbKFsRwBj3dNwo0
        M2FzLiyPeSkfKcBly7akzuGZDpi2B51LvufNMyKo8VtZlUmgwqUKx8q8Ha7DOV3+g8SFGC
        dUJFkMDylITqdFc+wvcKIuABKLrC5OmOaQd8tFjK4Y6gl/vfgFyR/VMjuBD+jEc/DlduJw
        UbWIZfT3RLKXT2h44n1fznqF/tlCvKBAjJFj3UIdGR0oz9pOhYjvVPTI+drYFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615027100;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSSfOnWXoj1UNYlFixyPMLY4tAQO/UE7XPtf2ZoG8ko=;
        b=y+CvJMj0OD+2qmMjS8gI3ytMvWA0nf/funjCiLZ+et5n3mDv/nxGI0CD6VDGcNlJgxHult
        K6Eh+djeXClk65DA==
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vdso] x86/vdso: Use proper modifier for len's format
 specifier in extract()
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210303064357.17056-1-jslaby@suse.cz>
References: <20210303064357.17056-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <161502709986.398.1775215743911969084.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     70c9d959226b7c5c48c119e2c1cfc1424f87b023
Gitweb:        https://git.kernel.org/tip/70c9d959226b7c5c48c119e2c1cfc1424f87b023
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Wed, 03 Mar 2021 07:43:57 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 06 Mar 2021 11:34:07 +01:00

x86/vdso: Use proper modifier for len's format specifier in extract()

Commit

  8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO functions")

prints length "len" which is size_t.

Compilers now complain when building on a 32-bit host:

  HOSTCC  arch/x86/entry/vdso/vdso2c
  ...
  In file included from arch/x86/entry/vdso/vdso2c.c:162:
  arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
  arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of \
	type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'}

So use proper modifier (%zu) for size_t.

 [ bp: Massage commit message. ]

Fixes: 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO functions")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/20210303064357.17056-1-jslaby@suse.cz
---
 arch/x86/entry/vdso/vdso2c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 1c7cfac..5264daa 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -35,7 +35,7 @@ static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
 	if (offset + len > data_len)
 		fail("section to extract overruns input data");
 
-	fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
+	fprintf(outfile, "static const unsigned char %s[%zu] = {", name, len);
 	BITSFUNC(copy)(outfile, data + offset, len);
 	fprintf(outfile, "\n};\n\n");
 }
