Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5E8264E15
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 21:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgIJS5c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgIJSzc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B853C061799;
        Thu, 10 Sep 2020 11:54:40 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O5Mk/SHA1ta4oUGKyfpviAv81OQkZj0rKwxnAwC46n4=;
        b=B7+XWiSbjwY+GKLCbILUtx/LO6qq5hlbkFLbj8l5WrYJmYB7yA2SwkzdzF9ETXfNMnbIzU
        +m4LQgwKhxEaDmXkKvcGDE7yH6YDU+yaUU1pebg1zRWLSvhdMmk5zVpxdDmMVUhjYBw5xy
        anrELrd2Y/hHFROH2BLnZTYt3tAvVdMLD1YH5QQdNMouXrCgysRfefOxFdo46MASgUmCO5
        NcD9TMcZrlgebNsYmAAYP8kMSlzjPh3Z2B0Zozb0pfvYZNGZn4FgTnAVs/OhIE7AWK0YmD
        JUMFDW9mbx2Vh4I1scCAO/BhPLRnjM7wbyRZC11Z4Agx80HiHheppFMjhYycrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764079;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=O5Mk/SHA1ta4oUGKyfpviAv81OQkZj0rKwxnAwC46n4=;
        b=+aq0mG4sMBHL/4NyzD3eFTR4jpfPuIRJnnbQSd+1n6yEi5JbLrhR7K1ERd1imCQOIO1M9T
        UOXZZ4xAmNhV/kAw==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Group headers to check in a single list
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407879.20229.2756534092720336411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3890b8d92710af75baedf291832cf40193b33454
Gitweb:        https://git.kernel.org/tip/3890b8d92710af75baedf291832cf40193b33454
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:19 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Group headers to check in a single list

In order to support multiple architectures and potentially different
sets of headers to compare against their kernel equivalent, it is
simpler to have all headers to check in a single list.

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/sync-check.sh | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index aa099b2..b5f5266 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -1,14 +1,18 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-FILES='
+FILES="
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 include/linux/static_call_types.h
-'
+arch/x86/include/asm/inat.h     -I '^#include [\"<]\(asm/\)*inat_types.h[\">]'
+arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
+arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
+arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
+"
 
 check_2 () {
   file1=$1
@@ -41,11 +45,12 @@ fi
 
 cd ../..
 
-for i in $FILES; do
-  check $i
-done
+while read -r file_entry; do
+    if [ -z "$file_entry" ]; then
+	continue
+    fi
 
-check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
-check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
-check arch/x86/lib/inat.c             '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
+    check $file_entry
+done <<EOF
+$FILES
+EOF
