Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2554F673
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jun 2022 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380571AbiFQLKs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jun 2022 07:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382307AbiFQLKp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jun 2022 07:10:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7E6CA92
        for <linux-tip-commits@vger.kernel.org>; Fri, 17 Jun 2022 04:10:43 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i29so6431229lfp.3
        for <linux-tip-commits@vger.kernel.org>; Fri, 17 Jun 2022 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=a5lpETF3CiAr1MD9se/qBuFLxUdbv1nm7l/Zsrl8+yFWc+taBtqRwVrI6CqWZSio6N
         0R/GxqHbvDQYj/NFN2n8p1JwVkJmrnXUdjSQO83PN/MBS+ysc4iceW595H54x1i710Ll
         FYx5ZZAK9JZFLQ388FDL1dy5cLZ8kaR60jD92as27qEgEZi+hgrqiMNy6YJ32fuLDcv/
         hHQUlzUmpEy3/3IvlKi6iUfcHVNZ534NgRf6wGQ+47jrqIWVg4cKYbRWiWMI3T4Jhi+Q
         Xq75cJ0pks/g/mxbKfe8Ak1RRS8ULqz1aa/d5BiKENEqkdtik2+BLOvWTy6WDtpEs+z0
         fGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=hctP6o7NZnjCShr/8zYU/tsiCfP/dYWoqL68QPdlo7ejgUJ3Z0bDUnQms4s6s/M+P8
         xwpzCm2uuix9e2KrEOr573DrPtb/XZwxlmSZZWMKDaQcKlxW6+4bPCov1IXytGyQoKY3
         zocUujj5aNC+gim3evkAdlpOepg5SfmN+hbfXK1XK7zYLP7eZWW4NfCh+WFJch7c0eoz
         4duNb97eAqZ4IqSdzJaWfI5p8328lYDR+/ZwKv4bvY7rC2ZQ36Y1ikTgrTXEpV5a9R+T
         xgHjo9K7T+kZ9AQGrc1Za7sV5U8ijHYHFCrHxOG+9xwmfIEm5odJhJBMMxhfDNMUzKvG
         LSnw==
X-Gm-Message-State: AJIora9mCaAo6Zn1973XhzL5QPI6Az5A1+NKV0mKi13eQq6pE5dnXAxP
        m0ntItcAwb0B6RMrC7c5cJJQA+UIn9haj5aZ2ns=
X-Google-Smtp-Source: AGRyM1v1wDuvX6n4XY7KoVwHSQTKQ+o32cf0zrXSJNM55HDBk1s+fYaML8/ymRMvfw9zftl0EfSWJ1FIxJgS2pf1fHY=
X-Received: by 2002:a05:6512:2286:b0:479:7a60:5e42 with SMTP id
 f6-20020a056512228600b004797a605e42mr5253740lfu.625.1655464242205; Fri, 17
 Jun 2022 04:10:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:10:41
 -0700 (PDT)
Reply-To: sj7209917@gmail.com
From:   Joseph smith <maelyskpeta@gmail.com>
Date:   Fri, 17 Jun 2022 04:10:41 -0700
Message-ID: <CACKGxpx1qvVYtiHHrZyM5G0z9SCjvAsXsGNJ81Ure7BFu2ZoKQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi   are you available to  speak now
Thanks
