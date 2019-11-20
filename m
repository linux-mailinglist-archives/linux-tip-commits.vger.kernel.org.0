Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DB9103B0A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Nov 2019 14:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfKTNVY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Nov 2019 08:21:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56810 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfKTNVY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv4-0007Be-Vg; Wed, 20 Nov 2019 14:21:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4449A1C1A19;
        Wed, 20 Nov 2019 14:21:05 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:05 -0000
From:   "tip-bot2 for Rajendra Nayak" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] dt-bindings: qcom,pdc: Add compatible for sc7180
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108092824.9773-8-rnayak@codeaurora.org>
References: <20191108092824.9773-8-rnayak@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157425606522.12247.12968768078402599671.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bf93b04cd85d74c34335e76882cf8bf206caab6e
Gitweb:        https://git.kernel.org/tip/bf93b04cd85d74c34335e76882cf8bf206caab6e
Author:        Rajendra Nayak <rnayak@codeaurora.org>
AuthorDate:    Fri, 08 Nov 2019 14:58:18 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:50 

dt-bindings: qcom,pdc: Add compatible for sc7180

Add the compatible string for sc7180 SoC from Qualcomm.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20191108092824.9773-8-rnayak@codeaurora.org
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 8e0797c..1df2939 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -17,7 +17,8 @@ Properties:
 - compatible:
 	Usage: required
 	Value type: <string>
-	Definition: Should contain "qcom,<soc>-pdc"
+	Definition: Should contain "qcom,<soc>-pdc" and "qcom,pdc"
+		    - "qcom,sc7180-pdc": For SC7180
 		    - "qcom,sdm845-pdc": For SDM845
 
 - reg:
