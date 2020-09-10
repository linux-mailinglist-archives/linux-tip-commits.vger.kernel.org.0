Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA47264DF5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 20:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgIJS5R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 14:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbgIJSz0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C384C061796;
        Thu, 10 Sep 2020 11:54:40 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ic3hdi2RqO94IWpp/XCMDz0Vb3iMW9EN6D9uU+BHyuI=;
        b=tLSOV0Jl/tate4DdxewF5EsBBwlhhJZisv4e/zdg6fSHPkKeA0RH/1UDGMdoefrKQJwbYD
        dkYm6DT0q753m4/OzSB1Ak4lln7V6sVLeFXP75PyVDzy3XDgGUekLO2c8za1dT8iyoMN3X
        GahDHMmmaS4JIv/TsBTG2KVRCT8ScTIX8Om1bdXkEOVs+WmuuPiux2BUUiF09+/br3DnkH
        l6RunA0rNcUt39EgQWOPvOkfCEgHuy7l8zfADeOWcTkmac1YqM9718bjv0YIr8QEe/MIRd
        oEbA0tX/7qRrROzuNaiafRDYmVKXLlNisPelvvdjhWKnEPx5psXpgmJlEBgtUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ic3hdi2RqO94IWpp/XCMDz0Vb3iMW9EN6D9uU+BHyuI=;
        b=UEH2MosbaI9+NThYo6Dfkcgo4WyMB/nQHxMajDF++1HuLxONZ1AOLaMM7SfSjuxSo5LdDm
        t8CIRxzdyfHWkYDQ==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make sync-check consider the target architecture
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407823.20229.5252021842988167178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bb090fdb70ecc51c91e1d86345adae064caa06c8
Gitweb:        https://git.kernel.org/tip/bb090fdb70ecc51c91e1d86345adae064caa06c8
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:20 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Make sync-check consider the target architecture

Do not take into account outdated headers unrelated to the build of the
current architecture.

[ jpoimboe: use $SRCARCH directly ]

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/sync-check.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index b5f5266..cea1c12 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -1,6 +1,12 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+if [ -z "$SRCARCH" ]; then
+	echo 'sync-check.sh: error: missing $SRCARCH environment variable' >&2
+	exit 1
+fi
+
+if [ "$SRCARCH" = "x86" ]; then
 FILES="
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
@@ -13,6 +19,7 @@ arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
 arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
 arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
 "
+fi
 
 check_2 () {
   file1=$1
