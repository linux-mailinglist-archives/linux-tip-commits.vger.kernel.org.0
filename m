Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF032D13A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 11:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbhCDKz1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 4 Mar 2021 05:55:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCDKzD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 4 Mar 2021 05:55:03 -0500
Date:   Thu, 04 Mar 2021 10:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614855262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kr2AYH2r5OfwUqHQsDSdPUZHn/tXpVHWgeafjo/UTKI=;
        b=av8s+J8F3rZydYOtSE00pi27pAOig75+yad0O2UR+P/HG8Wt7fApFIC74zNbiohLACECRd
        Q912GABr+J3Q4stV4l4xXQbfFh2ymjfNQxxFWu8oeKJeHjNf3GKbFsUFv3ukyju8Yp8KCt
        7L2iHcwZb6EF8kqD/8hx3n9FPUhidFdAaVtIFcZfxMsi6sthT52fEcCd9wUnWFOIhZz6U8
        DGHSg3WCKkw53xoPWgO2o1kNydtBMVOgUoqUuEETCeiHGyvyjRoyoC1jvbnNCIlN7MAL0j
        IyQ7A3JPCzUHexV1cCaQEIX0xKb/BSCEYRAmxpoZvEFw0L3flu3J/gWdnHBNaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614855262;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kr2AYH2r5OfwUqHQsDSdPUZHn/tXpVHWgeafjo/UTKI=;
        b=Ysa/11zkHII1Ajjk8JjpknC58EuLUdJxZ9SJDxcj+guIAei2lQCAgI/VvG+Ma9+1Wkg/fa
        R8k+9dP8Ax7stvCQ==
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
Message-ID: <161485526193.398.16290223266017455926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/vdso branch of tip:

Commit-ID:     6bdbe1760651484b0fe6f6d0cc3a2fe8741e6f87
Gitweb:        https://git.kernel.org/tip/6bdbe1760651484b0fe6f6d0cc3a2fe8741e6f87
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Wed, 03 Mar 2021 07:43:57 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 04 Mar 2021 11:47:01 +01:00

x86/vdso: Use proper modifier for len's format specifier in extract()

Commit

  8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO functions")

prints length "len" which is size_t. Compilers now complain on 32-bit:

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
