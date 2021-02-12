Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74E7319F06
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhBLMpo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhBLMnQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37630C061794;
        Fri, 12 Feb 2021 04:42:36 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QJc8+K4kxJpchK44A1PBsFCR3RnKwwZQPa4HlzorH5g=;
        b=LlzdyFEVvXF+iTzvIUKmHsBsxeHdfeih0lx2Vae3SFMU3bhVi9o6GVgtfL3GFoxM+Q3dz7
        KevGeL1mBHHx4bffo+j9nE8MzHEfxjJJ0isY98gYvMmGnOZqlTBvzr22j/HkRKsNpzBK9K
        7D3oz+mOa3sSuhF4y/c/DWk8eIG9omqFWvLs9e3EG9St9ROFV4P6i+TsUw2XaDa3VsLApq
        WFqtS93ymW6DM8XLYrZilaXugAaIPtKPJJmlyVI58Mdm4sRTaAamPhCWZ/utsdcX/9JWbZ
        oc/3MThJx6ztvMe1WX/MRUycNL3mD+RmV8ikAb2xl74kDeqYxtFnEoNluBClrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QJc8+K4kxJpchK44A1PBsFCR3RnKwwZQPa4HlzorH5g=;
        b=32q0Dxaxfgor2sOfCVJpIZpt8SKUk/gsGC978br3jDOWwXltTYHvi+9irYKNDbb46nmmho
        Gt1V80d0tpim6CAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add config2csv.sh script to compare torture
 scenarios
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344790.23325.17987870621107139155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d4a945e260b9eb59b1a90b9d6f2b0b953e27f803
Gitweb:        https://git.kernel.org/tip/d4a945e260b9eb59b1a90b9d6f2b0b953e27f803
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 17:38:48 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:19 -08:00

torture: Add config2csv.sh script to compare torture scenarios

This commit adds a config2csv.sh script that converts the specified
torture-test scenarios' Kconfig options and kernel-boot parameters to
.csv format.  This allows easier comparison of scenarios when one fails
and another does not.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/config2csv.sh | 67 +++++++++++-
 1 file changed, 67 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/config2csv.sh

diff --git a/tools/testing/selftests/rcutorture/bin/config2csv.sh b/tools/testing/selftests/rcutorture/bin/config2csv.sh
new file mode 100755
index 0000000..d5a1663
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/config2csv.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Create a spreadsheet from torture-test Kconfig options and kernel boot
+# parameters.  Run this in the directory containing the scenario files.
+#
+# Usage: config2csv path.csv [ "scenario1 scenario2 ..." ]
+#
+# By default, this script will take the list of scenarios from the CFLIST
+# file in that directory, otherwise it will consider only the scenarios
+# specified on the command line.  It will examine each scenario's file
+# and also its .boot file, if present, and create a column in the .csv
+# output file.  Note that "CFLIST" is a synonym for all the scenarios in the
+# CFLIST file, which allows easy comparison of those scenarios with selected
+# scenarios such as BUSTED that are normally omitted from CFLIST files.
+
+csvout=${1}
+if test -z "$csvout"
+then
+	echo "Need .csv output file as first argument."
+	exit 1
+fi
+shift
+defaultconfigs="`tr '\012' ' ' < CFLIST`"
+if test "$#" -eq 0
+then
+	scenariosarg=$defaultconfigs
+else
+	scenariosarg=$*
+fi
+scenarios="`echo $scenariosarg | sed -e "s/\<CFLIST\>/$defaultconfigs/g"`"
+
+T=/tmp/config2latex.sh.$$
+trap 'rm -rf $T' 0
+mkdir $T
+
+cat << '---EOF---' >> $T/p.awk
+END	{
+---EOF---
+for i in $scenarios
+do
+	echo '	s["'$i'"] = 1;' >> $T/p.awk
+	grep -v '^#' < $i | grep -v '^ *$' > $T/p
+	if test -r $i.boot
+	then
+		tr -s ' ' '\012' < $i.boot | grep -v '^#' >> $T/p
+	fi
+	sed -e 's/^[^=]*$/&=?/' < $T/p |
+	sed -e 's/^\([^=]*\)=\(.*\)$/\tp["\1:'"$i"'"] = "\2";\n\tc["\1"] = 1;/' >> $T/p.awk
+done
+cat << '---EOF---' >> $T/p.awk
+	ns = asorti(s, ss);
+	nc = asorti(c, cs);
+	for (j = 1; j <= ns; j++)
+		printf ",\"%s\"", ss[j];
+	printf "\n";
+	for (i = 1; i <= nc; i++) {
+		printf "\"%s\"", cs[i];
+		for (j = 1; j <= ns; j++) {
+			printf ",\"%s\"", p[cs[i] ":" ss[j]];
+		}
+		printf "\n";
+	}
+}
+---EOF---
+awk -f $T/p.awk < /dev/null > $T/p.csv
+cp $T/p.csv $csvout
