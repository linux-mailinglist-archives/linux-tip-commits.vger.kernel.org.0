Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BC1538491
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 May 2022 17:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiE3PQF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 30 May 2022 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiE3PPy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 30 May 2022 11:15:54 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499391B1F6E
        for <linux-tip-commits@vger.kernel.org>; Mon, 30 May 2022 07:15:01 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p74so11426208iod.8
        for <linux-tip-commits@vger.kernel.org>; Mon, 30 May 2022 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=ijwFqBxYOk6oXgiuXqu7ifnmCnTVPU3kqzhUV4L4E7DPWK5aYL16pZHqr3PbtlU0Hr
         PTXQkxeSS0U18lg4hhPmpjKSSoQBx9+vfeJSdUi8LJcvv/rVTqbZmrirjcxaLakJTNKC
         cWFx5iXqrvp9daqrjzMe4BCSQ5qgim9b6dA1ECAxrtsVCIkdw8P6T5MA5KBFbSXnJvmm
         26Khx/Df+OLFBdGL2WIJsC8P1OZE2oYTjBBcwnm+YJdjWAEypQIz8o4pyOFlGKOKpx40
         dmWk66kSG44WKnr4Brtjk9I7iyAP8j44Z7I+PmMuJxEhHTAqF3a38+srDyB9u3/ki4Ik
         xqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=Ue9ucayeW1RlHjQ6LL/ZZ0UzJzjLf7b7uEXStyxU7FJGFj8tBHA8/PHBVxebYRgCcF
         HHWmnqib3f4QTJ2GMuQ5Kf46SbSf62g81UKQHVeuph3UsBD7Zbg2fmmLDLtaQ2QZ2Dt+
         xZ8hX+Op/Wed9mUAkdkdfm+YuYfSgO4wyEYCGd5PjdzuvAqlLl9+O+HLTLL0JQXlZ0vq
         vm6EsAGJ3UhQrKnjNDz14yAWSGAedxqUzMItm4WEdLX8QhgkLBxp4KpTTjS9b8pf9VRV
         BUiUf/imydYPOgDSvWNScXB/QIyn3zGGAnVF/XSAvNjjis3/4FnJ+QbvLNNQE3YHUsd2
         X31w==
X-Gm-Message-State: AOAM533FyqbJ6n/A6+Aa1ROlG5DoXjsfTFVxfSnEp0olgBzkrd2ghx7g
        gswarDWe61tBbihpFjWsmMRcFlMjOvS7I08ZifY=
X-Google-Smtp-Source: ABdhPJxlHySKEaatbQPK4g5wgKY+rvDZDBa0t8mxeqtl3RyqROStu4SeZurOa2fdwvHhZu51mXhicEwFOPYWk0RsV1o=
X-Received: by 2002:a6b:3f03:0:b0:65a:4236:bb3e with SMTP id
 m3-20020a6b3f03000000b0065a4236bb3emr25130125ioa.194.1653920098173; Mon, 30
 May 2022 07:14:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:f06:0:0:0:0 with HTTP; Mon, 30 May 2022 07:14:57
 -0700 (PDT)
Reply-To: barristerbenjamin221@gmail.com
From:   Attorney Amadou <koadaidrissa1@gmail.com>
Date:   Mon, 30 May 2022 07:14:57 -0700
Message-ID: <CAOh7+P-4HvQzB8uKZTAN+ECXBqWWYP5nXwvQ4oGCZSeCBU48pw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d41 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [koadaidrissa1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [barristerbenjamin221[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [koadaidrissa1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

SGVsbG8gZGVhciBmcmllbmQuDQoNClBsZWFzZSBJIHdpbGwgbG92ZSB0byBkaXNjdXNzIHNvbWV0
aGluZyB2ZXJ5IGltcG9ydGFudCB3aXRoIHlvdSwgSQ0Kd2lsbCBhcHByZWNpYXRlIGl0IGlmIHlv
dSBncmFudCBtZSBhdWRpZW5jZS4NCg0KU2luY2VyZWx5Lg0KQmFycmlzdGVyIEFtYWRvdSBCZW5q
YW1pbiBFc3EuDQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCuimquaEm+OB
quOCi+WPi+S6uuOAgeOBk+OCk+OBq+OBoeOBr+OAgg0KDQrnp4Hjga/jgYLjgarjgZ/jgajpnZ7l
uLjjgavph43opoHjgarjgZPjgajjgavjgaTjgYTjgaboqbHjgZflkIjjgYbjga7jgYzlpKflpb3j
gY3jgafjgZnjgIHjgYLjgarjgZ/jgYznp4HjgavogbTooYbjgpLkuI7jgYjjgabjgY/jgozjgozj
gbDnp4Hjga/jgZ3jgozjgpLmhJ/orJ3jgZfjgb7jgZnjgIINCg0K5b+D44GL44KJ44CCDQrjg5Dj
g6rjgrnjgr/jg7zjgqLjg57jg4njgqXjg5njg7Pjgrjjg6Pjg5/jg7NFc3HjgIINCg==
