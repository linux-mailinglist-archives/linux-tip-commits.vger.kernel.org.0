Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C2851E0C5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 May 2022 23:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444333AbiEFVNN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 May 2022 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444297AbiEFVNM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 May 2022 17:13:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1D6F499
        for <linux-tip-commits@vger.kernel.org>; Fri,  6 May 2022 14:09:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id iq10so8081251pjb.0
        for <linux-tip-commits@vger.kernel.org>; Fri, 06 May 2022 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=DCL4ASSQyWhAON34kE5OIISSqSj3rOCfF8Ciqjh+lsqRdCfgeusA5Vwv0XnJkYI/K8
         PpoBtZS88yuL3et/lZLKleXxq4URSZD9f6MROtdldcj3gOmiMCUI/6TV1Dl/T+qpwJiw
         M0N+RaWrDo6cEqXCC4jcgWP8yqP5i27fdlJmL+Z22MNaap80xcYhj1kcUEIwB2pTrZYY
         bvvbxOCDGxpg/KNpF54H7KtPoC+ybJ/VsbbP4Y4Ldgfhj+OsOwqpuNJpDXQhyZEajcO2
         TQ+8Ad8csIfLm6I1rNVsM3KaAaNUHUcZcLEHvw01t2/Qn5zFCtxGu68RLxA3LTyrzGSv
         07+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=deWEOtULbZ8rmNfnC3wLuBmo5RHFIKzs65P7r4upQRvF4igGZg16RNqvNa+q5szER7
         IKYWywzvJgiGwUBR3LA+qFHl+77rGIBR4SpZLAbX90ARNuEG2hk1PsDv0luQzr3gNu/5
         qB7qdl8lLcrIDcCYIWxelh6bLulZskAY7raqfe32GuBlWUqxJxdnfa1OjeE9o9Pi5mDD
         eFIdj4DUuVJmUBu+x51X1gnVTVDtuKIoFi1q9Ag1u0q7EKhlTU4J34+ARx7gZjvG+sCz
         ZmWTp0XeYQ3babLDg69CKBHIoy8/wBnLGMvaGk+WMRlyP5/OBGhuikNWGzF5IS1/nJVK
         LYjw==
X-Gm-Message-State: AOAM530slrdnoLb/3+yqjQmWG/3NCKOGVgijxol05+zH4rNLXBWdNezI
        RWac3nZFupn8z9GbJ+VqZAjt1tb1755o6YOhfg==
X-Google-Smtp-Source: ABdhPJwp4Ke3UOg5WGZvnc+9zoj6LuBlmjaWEumAhXp6nyRAoOsi+A9K7QpSIh/DOmfrS0/kdtzDsFQAu7yldmf5qAo=
X-Received: by 2002:a17:902:a501:b0:153:f956:29f0 with SMTP id
 s1-20020a170902a50100b00153f95629f0mr5613774plq.120.1651871367333; Fri, 06
 May 2022 14:09:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:09:26 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:09:26 +0000
Message-ID: <CAD_xG_qmkaecRMLoM=8Av+-AOUpQv=7REEM0B2SR_6pXvr6_sQ@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1042 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4851]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
