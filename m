Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D1468A96B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  4 Feb 2023 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjBDKRb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 4 Feb 2023 05:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjBDKRY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 4 Feb 2023 05:17:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5748E6D062;
        Sat,  4 Feb 2023 02:17:14 -0800 (PST)
Date:   Sat, 04 Feb 2023 10:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6BthIi67OUHpg6L7JkY57ZSDufk0vweKeRJuQSWGpQ=;
        b=3ryx7rJy3XzLf7X7Gp55XVwRKXtTwCZfN0eTgCL4bls2rNY18iVd/IL7vk/lo8ooTnnrxf
        rsO0/3hdo/gAswYOEHOrPHr4tzHkMSuuxJ/hMYVx59fj3vWD/ZHK6kPJNitzUZ0kHUzJ4n
        DXgubygA8TMj6UWLldg6VxPwNWT5hhJpnu6yc6RlS9p7RT6bLdvUlWksYa8GyV3XymLZkl
        kB5buyRTZQms630jfoYzpIJIgtixpc/XHDu/KvRi83fiiKIQ65W97nRpplZwdyXv9glwAj
        vBLh82xwxHWjt5yr6rYnKJisy0jCyRdZZevKfzmOQm1J4MZytHCOTMtvda/G1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675505832;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I6BthIi67OUHpg6L7JkY57ZSDufk0vweKeRJuQSWGpQ=;
        b=xbajiQhfK96+WQ54MU8X5Vqaf5+9oIzDb7TRQMfcqW6rvD/TkVpCj2SJ9h26HM/OWGO3E+
        iRGySrLPM561CIBg==
From:   tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Optimize layout of struct special_alt
Cc:     linux@weissschuh.net, Josh Poimboeuf <jpoimboe@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221216-objtool-memory-v2-7-17968f85a464@weissschuh.net>
References: <20221216-objtool-memory-v2-7-17968f85a464@weissschuh.net>
MIME-Version: 1.0
Message-ID: <167550583123.4906.13991632957721307656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a20717aca33b1ff133f513721050fe6c3d7f97b5
Gitweb:        https://git.kernel.org/tip/a20717aca33b1ff133f513721050fe6c3d7=
f97b5
Author:        Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
AuthorDate:    Tue, 27 Dec 2022 16:01:03=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 01 Feb 2023 09:15:24 -08:00

objtool: Optimize layout of struct special_alt

Reduce the size of struct special_alt from 72 to 64 bytes.

Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/r/20221216-objtool-memory-v2-7-17968f85a464@wei=
ssschuh.net
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/special.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/=
objtool/special.h
index dc4721e..86d4af9 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -19,6 +19,7 @@ struct special_alt {
 	bool skip_orig;
 	bool skip_alt;
 	bool jump_or_nop;
+	u8 key_addend;
=20
 	struct section *orig_sec;
 	unsigned long orig_off;
@@ -27,7 +28,6 @@ struct special_alt {
 	unsigned long new_off;
=20
 	unsigned int orig_len, new_len; /* group only */
-	u8 key_addend;
 };
=20
 int special_get_alts(struct elf *elf, struct list_head *alts);
